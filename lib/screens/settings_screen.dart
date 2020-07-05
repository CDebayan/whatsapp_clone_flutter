import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/screens/user_profile_screen.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "SettingsScreen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with Functionality {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: _buildWidgets(),
    );
  }

  Widget _buildWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is Loaded) {
                return ListTile(
                  leading: ProfileImageView(
                    profileImage: isValidString(state.userDetails?.imageUrl)
                        ? state.userDetails?.imageUrl
                        : "",
                  ),
                  title: Text(isValidString(state.userDetails?.name)
                      ? state.userDetails?.name
                      : ""),
                  subtitle: Text(isValidString(state.userDetails?.about)
                      ? state.userDetails?.about
                      : ""),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(UserProfileScreen.routeName);
                  },
                );
              } else {
                return ListTile(
                  leading: ProfileImageView(
                    profileImage: "",
                  ),
                  title: Text(""),
                  subtitle: Text(""),
                );
              }
            },
          ),
          Divider(),
          ListTile(
            leading: CircleContainer(
              height: 45,
              width: 45,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.vpn_key,
                color: Constants.colorPrimary,
                size: 20,
              ),
            ),
            title: Text("Account"),
            subtitle: Text("Privacy, security, change number"),
          ),
          ListTile(
            leading: CircleContainer(
              height: 45,
              width: 45,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.message,
                color: Constants.colorPrimary,
                size: 20,
              ),
            ),
            title: Text("Chats"),
            subtitle: Text("Theme, wallpapers, chat history"),
          ),
          ListTile(
            leading: CircleContainer(
              height: 45,
              width: 45,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.notifications,
                color: Constants.colorPrimary,
                size: 20,
              ),
            ),
            title: Text("Notifications"),
            subtitle: Text("Message, group & call tones"),
          ),
          ListTile(
            leading: CircleContainer(
              height: 45,
              width: 45,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.data_usage,
                color: Constants.colorPrimary,
                size: 20,
              ),
            ),
            title: Text("Data and storage usage"),
            subtitle: Text("Network usage, auto-download"),
          ),
          ListTile(
            leading: CircleContainer(
              height: 45,
              width: 45,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.help_outline,
                color: Constants.colorPrimary,
                size: 20,
              ),
            ),
            title: Text("Help"),
            subtitle: Text("FAQm contact us, privacy policy"),
          ),
          Divider(indent: 72),
          ListTile(
            leading: CircleContainer(
              height: 45,
              width: 45,
              color: Colors.transparent,
              containerChild: Icon(
                Icons.group,
                color: Constants.colorPrimary,
                size: 20,
              ),
            ),
            title: Text("Invite a friend"),
          ),
          SizedBox(
            height: 24,
          ),
          Footer()
        ],
      ),
    );
  }
}
