import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_event.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/user_list_model.dart';
import 'package:whatsappcloneflutter/services/dio_client.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class UserListScreen extends StatefulWidget {
  static const String routeName = "UserListScreen";

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> with Functionality {
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Select contact"),
        BlocBuilder<UserListBloc, UserListState>(
          builder: (context,state){
          if(state is LoadedState){
            return Text(
              "${state.userModel.length} contacts",
              style: TextStyle(fontSize: 12),
            );
          } else{
            return Container();
          }
          },
        ),

          ],
        ),
        actions: <Widget>[
          BlocBuilder<UserListBloc, UserListState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Container(
                  width: 16,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Constants.colorWhite),
                    strokeWidth: 2,
                  ),
                );
              }
              return IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {},
              );
            },
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
    _blocInstance().add(PermissionEvent(status));
  }

  Widget _buildWidgets() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleContainer(
                  height: 45,
                  width: 45,
                  color: Constants.colorPrimary,
                  containerChild: Icon(
                    Icons.group,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "New group",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                CircleContainer(
                  height: 45,
                  width: 45,
                  color: Constants.colorPrimary,
                  containerChild: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "New Contact",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            _buildUserList(),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
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
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Invite friends",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
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
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Contacts help",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        if (state is LoadedState) {
          if (isValidList(state.userModel)) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.userModel.length,
                itemBuilder: (context, index) {
                  return _buildUserItem(state.userModel[index]);
                });
          }
        }
        return Text(
          "No WhatsApp contacts",
          style: TextStyle(fontSize: 16),
        );
      },
    );
  }

  Widget _buildUserItem(UserModel userModel) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: ProfileImageView(profileImage: "${DioClient.imageBaseUrl}${userModel.profileImage}"),

      title: Text(userModel.name),
      subtitle: Text(userModel.about),
    );
  }

  //region blocInstance
  UserListBloc _blocInstance() {
    return BlocProvider.of<UserListBloc>(_context);
  }

  //endregion

  @override
  void dispose() {
    super.dispose();
  }
}
