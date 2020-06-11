import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildWidgets();

  }

  Widget _buildWidgets() {
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
              child: Row(children: <Widget>[
                Text("Start a chat",style: TextStyle(fontSize: 20,color: Constants.colorPrimaryDark),),
                SizedBox(width: 8,),
                Icon(Icons.arrow_forward,color: Constants.colorPrimaryDark,)
              ],),
            )),
        Center(child: Text("You have 160 contacts on WhatsApp",style: TextStyle(color: Constants.colorDefaultText),),),
      ],
    );
  }
}
