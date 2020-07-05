import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = "UserProfileScreen";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with Functionality {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
        if (state is NoInternet) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildWidget(state);
        }
      }),
    );
  }

  Widget _buildWidget(UserProfileState state) {
    bool isImageLoading = state.isImageLoading;
    bool isNameLoading = state.isNameLoading;
    bool isAboutLoading = state.isAboutLoading;
    String imageUrl = state.userDetails?.imageUrl ?? "";
    String name = state.userDetails?.name ?? "";
    String about = state.userDetails?.about ?? "";
    String mobile = "";

    if (isValidObject(state.userDetails)) {
      if (isValidString(state.userDetails.countryCode) && isValidString(state.userDetails.mobileNo)) {
        mobile = "+${state.userDetails.countryCode} ${state.userDetails.mobileNo}";
      }
    }

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
            profileImage: imageUrl,
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
              Text(name),
              SizedBox(
                height: 8,
              ),
            ],
          ),
          subtitle: Text(
              "This is not your username or pin.This name will be visible to your WhatsApp contacts."),
          trailing: IconButton(
            icon: isNameLoading ? Progress() :Icon(
              Icons.edit,
              size: 20,
            ),
            onPressed: () {
              _updateNameBottomSheet(name);
            },
          ),
        ),
        Divider(
          indent: 72,
        ),
        ListTile(
          leading: Icon(
            Icons.error_outline,
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
              Text(about),
            ],
          ),
          trailing: IconButton(
            icon: isAboutLoading ? Progress() :Icon(
              Icons.edit,
              size: 20,
            ),
            onPressed: () {
            },
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
              Text(mobile),
            ],
          ),
        ),
      ],
    );
  }

  UserProfileBloc _blocInstance() {
    return BlocProvider.of<UserProfileBloc>(context);
  }

  void _updateNameBottomSheet(String name) {
    final TextEditingController _controller = TextEditingController(text: name);
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enter your name',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _controller,
              autofocus: true,
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: Constants.colorPrimaryDark,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                SizedBox(
                  width: 32,
                ),
                InkWell(
                    onTap: () {
                      String name = _controller.text.toString().trim();
                      Navigator.of(context).pop();
                      _blocInstance().add(UpdateNameEvent(name));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            color: Constants.colorPrimaryDark,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }


}
