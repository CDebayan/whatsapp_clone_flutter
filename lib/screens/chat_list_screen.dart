import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/chat_list_bloc/chat_list_bloc.dart';
import 'package:whatsappcloneflutter/blocs/chat_list_bloc/chat_list_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/chat_list_model.dart';
import 'package:whatsappcloneflutter/services/dio_client.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> with Functionality {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
      if (state is RequiredPermission) {
        return _requiredPermissionWidget();
      } else if (state is LoadedChatList) {
        return _buildWidgets(state);
      }
      return Container();
    });
  }

  Widget _buildWidgets(LoadedChatList state) {
    if (isValidList(state.chatList)) {
      return ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return _buildChatItem(state.chatList[0]);
          });
    } else {
      return Stack(
        children: <Widget>[
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 40),
                height: 90,
                color: Constants.colorLightGrey,
                child: Row(
                  children: <Widget>[
                    Text(
                      "Start a chat",
                      style: TextStyle(
                          fontSize: 20, color: Constants.colorPrimaryDark),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Constants.colorPrimaryDark,
                    )
                  ],
                ),
              )),
          Center(
            child: Text(
              "You have 160 contacts on WhatsApp",
              style: TextStyle(color: Constants.colorDefaultText),
            ),
          ),
        ],
      );
    }
  }

  Widget _requiredPermissionWidget() {
    return Container(
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleContainer(
            height: 200,
            width: 200,
            containerChild: Icon(
              MdiIcons.contacts,
              color: Colors.white,
              size: 80,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "To help you message friends and family on WhatsApp, allow WhatsApp access to your contacts. Tap Settings > Permissions, and turn Contacts on.",
            style: TextStyle(height: 1.4),
          ),
          SizedBox(
            height: 24,
          ),
          Button(
              text: "SETTINGS",
              onPressed: () {
                openAppSettings();
              })
        ],
      ),
    );
  }

  Widget _buildChatItem(ChatList chatList) {
    String imageUrl = "";
    String userName = "";
    String message = "";
    String time = "";

    if (isValidObject(chatList)) {
      if (isValidString(chatList.message)) {
        message = chatList.message;
      }
      if (isValidString(chatList.updatedAt)) {
        time = chatList.updatedAt;
      }
      if (isValidObject(chatList.user)) {
        if (isValidString(chatList.user.name)) {
          userName = chatList.user.name;
        }
        if (isValidString(chatList.user.imageUrl)) {
          imageUrl = "${DioClient.imageBaseUrl}${chatList.user.imageUrl}";
        }
      }
    }

    return ListTile(
      leading: ProfileImageView(profileImage: imageUrl),
      title: Text(userName),
      subtitle: Text(message),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
