import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/screens/chat_screen.dart';
import 'package:whatsappcloneflutter/screens/user_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "DashboardScreen";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          backgroundColor: Constants.colorPrimary,
          onPressed: () {
            Navigator.of(context).pushNamed(UserListScreen.routeName);
          },
        ),
        appBar: AppBar(
          title: Text("WhatsApp"),
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),onPressed: (){},),
            IconButton(icon: Icon(Icons.more_vert),onPressed: (){},),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "STATUS",
              ),
              Tab(
                text: "CALLS",
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView( children: <Widget>[
            Text("data"),
            ChatScreen(),
            Text("data"),
            Text("data"),
          ]),
        ),
      ),
    );
  }
}
