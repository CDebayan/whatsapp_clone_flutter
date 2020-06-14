import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_event.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class UserListScreen extends StatefulWidget {
  static const String routeName = "UserListScreen";

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserListBloc _userListBloc;


  @override
  void initState() {
    super.initState();
    _userListBloc = UserListBloc();
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Select contact"),
            Text("160 contacts",style: TextStyle(fontSize: 12),),
          ],
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildWidgets(),
    );
  }

  void _checkPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    _userListBloc.add(PermissionEvent(status));
  }

  Widget _buildWidgets() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            CircleContainer(
              height: 40,
              width: 40,
              color: Constants.colorPrimary,
              containerChild: Icon(
                Icons.group,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 16,),
            Text("New group",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
          ],),

          SizedBox(height: 16,),

          Row(children: <Widget>[
            CircleContainer(
              height: 40,
              width: 40,
              color: Constants.colorPrimary,
              containerChild: Icon(
                Icons.group,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 16,),
            Text("New Contact",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
          ],),


          SizedBox(height: 16,),

          _buildUserList(),

          SizedBox(height: 16,),

          Row(children: <Widget>[
            CircleContainer(
              height: 40,
              width: 40,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.share,
                color: Colors.grey,
                size: 20,
              ),
            ),
            SizedBox(width: 16,),
            Text("Invite friends",style: TextStyle(fontSize: 16),)
          ],),

          SizedBox(height: 16,),

          Row(children: <Widget>[
            CircleContainer(
              height: 40,
              width: 40,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.help,
                color: Colors.grey,
                size: 20,
              ),
            ),
            SizedBox(width: 16,),
            Text("Contacts help",style: TextStyle(fontSize: 16),)
          ],),

        ],),
      ),
    );
  }

  Widget _buildUserList() {
    return BlocBuilder(
        bloc: _userListBloc,
        builder: (context,state){
      return Text("No WhatsApp contacts",style: TextStyle(fontSize: 16),);
    })
;  }

  @override
  void dispose() {
    super.dispose();
    _userListBloc.close();
  }

}
