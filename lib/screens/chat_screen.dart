import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_bloc.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_event.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/chat_list_model.dart';
import 'package:whatsappcloneflutter/models/user_chat_model.dart';
import 'package:whatsappcloneflutter/services/dio_client.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "ChatScreen";
  UserData userData;

  ChatScreen(this.userData);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with Functionality {
  ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    if (isValidObject(widget.userData) &&
        isValidObject(widget.userData.userId)) {
      _chatBloc.add(FetchUserChat(widget.userData.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            ProfileImageView(
              profileImage:
                  "${DioClient.imageBaseUrl}${widget.userData?.imageUrl ?? ""}",
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userData?.name ?? ""),
                Text(
                  "online",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                Constants.chatBackground,
                fit: BoxFit.fill,
              )),
          Column(
            children: [
              _buildChatList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        if (isValidList(state.chatList)) {
          return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: state.chatList.length,
              itemBuilder: (context, index) {
                UserChatList chatItem = state.chatList[index];
                return _buildChatItem(chatItem);
              });
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildChatItem(UserChatList chatItem) {
    String message = "";
    String time = "";
    String user = "";

    if (isValidString(chatItem.message)) {
      message = chatItem.message;
    }
    if (isValidString(chatItem.updatedAt)) {
      time = convertTime(chatItem.updatedAt);
    }
    if (isValidObject(chatItem.user) &&
        isValidObject(chatItem.user.userId) &&
        isValidObject(widget.userData) &&
        isValidObject(widget.userData.userId)) {
      if (chatItem.user.userId == widget.userData.userId) {
        user = "me";
      } else {
        user = "other";
      }
    }
    return Align(
      alignment: user == "me" ? Alignment(1, 0) : Alignment(-1, 0),
      child: Container(
        margin: user == "me"
            ? EdgeInsets.only(left: 50, bottom: 16)
            : EdgeInsets.only(right: 50, bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            topRight: user == "me" ? Radius.circular(0) : Radius.circular(5),
            topLeft: user == "me" ? Radius.circular(5) : Radius.circular(0),
            bottomRight: Radius.circular(5),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 4, bottom: 5, left: 8, right: 8),
            color: user == "me" ? Constants.colorLightGreen : Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(message),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 10, color: Constants.colorDefaultText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
