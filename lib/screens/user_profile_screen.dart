import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = "UserProfileScreen";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
        if (state is LoadedState) {
          return ListView(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Center(
                child: ProfileImageView(
                  height: 150,
                  width: 150,
                  showCamera: true,
                  profileImage: state.userDetails.imageUrl ?? "",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Constants.colorPrimary,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Name",
                        style: TextStyle(
                            color: Constants.colorDefaultText, fontSize: 14)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(state.userDetails.name ?? ""),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                subtitle: Text(
                    "This is not your username or pin.This name will be visible to your WhatsApp contacts."),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(
                indent: 72,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Constants.colorPrimary,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("About",
                        style: TextStyle(
                            color: Constants.colorDefaultText, fontSize: 14)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(state.userDetails.about ?? ""),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(
                indent: 72,
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Constants.colorPrimary,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Phone",
                        style: TextStyle(
                            color: Constants.colorDefaultText, fontSize: 14)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                        "+${state.userDetails.countryCode} ${state.userDetails.mobileNo}"),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      }),
    );
  }
}
