import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            ProfileImageView(
              profileImage: "",
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: [
                Text("Name"),
                Text(
                  "Last Seen",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.video_call), onPressed: (){}),
          IconButton(icon: Icon(Icons.call), onPressed: (){}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){}),
        ],
      ),
    );
  }
}
