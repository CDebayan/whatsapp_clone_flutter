import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = "AboutScreen";

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with Functionality {
  List<String> _aboutList = [
    "Available",
    "Busy",
    "At school",
    "At the movies",
    "At work",
    "Battery about to die",
    "Cant't talk, WhatsApp only",
    "In a meeting",
    "At the gym",
    "Sleeping",
    "Urgent calls only"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
        if (state is NoInternet) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Text(
                  "Currently set to",
                  style: TextStyle(color: Constants.colorPrimary),
                ),
              ),
              _buildWidget(state),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Text(
                  "Select About",
                  style: TextStyle(color: Constants.colorPrimary),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _aboutList.length,
                    itemBuilder: (context, index) {
                      return _buildAboutItem(index, state);
                    }),
              ),
            ],
          );
        }
      }),
    );
  }

  ListTile _buildAboutItem(int index, UserProfileState state) {
    bool showSelected = false;

    if (isValidObject(state.userDetails) &&
        isValidString(state.userDetails.about)) {
      if (state.userDetails.about == _aboutList[index]) {
        showSelected = true;
      }
    }

    return ListTile(
      contentPadding: EdgeInsets.only(left: 24, right: 24),
      title: Text(_aboutList[index]),
      trailing: showSelected
          ? Icon(
              Icons.check,
              color: Constants.colorPrimary,
            )
          : null,
      onTap: (){
        _blocInstance().add(UpdateAboutEvent(_aboutList[index]));
      },
    );
  }

  Widget _buildWidget(UserProfileState state) {
    bool isAboutLoading = state.isAboutLoading;
    String about = state.userDetails?.about ?? "";

    return ListTile(
      contentPadding: EdgeInsets.only(left: 24, right: 24),
      title: Text(about),
      trailing: IconButton(
        icon: isAboutLoading
            ? Progress()
            : Icon(
                Icons.edit,
                size: 20,
              ),
        onPressed: () {
          _updateAboutBottomSheet(about);
        },
      ),
    );
  }

  void _updateAboutBottomSheet(String about) {
    final TextEditingController _controller =
        TextEditingController(text: about);
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
                      String about = _controller.text.toString().trim();
                      Navigator.of(context).pop();
                      _blocInstance().add(UpdateAboutEvent(about));
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

  UserProfileBloc _blocInstance() {
    return BlocProvider.of<UserProfileBloc>(context);
  }
}
