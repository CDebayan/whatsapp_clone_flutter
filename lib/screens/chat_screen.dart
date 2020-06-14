import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_bloc.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_event.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc();
    _checkPermission();
    _getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _chatBloc,
        builder: (context, state) {
          if (state is RequiredPermissionState) {
            return _requiredPermissionWidget();
          } else if (state is PermissionGrantedState) {
            return _buildWidgets();
          }
          return Container();
        });
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

  void _checkPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    _chatBloc.add(PermissionEvent(status));
  }

  @override
  void dispose() {
    super.dispose();
    _chatBloc.close();
  }

  void _getContactList() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(
        withThumbnails: false,
        photoHighResolution: false,
        orderByGivenName: false,
        iOSLocalizedLabels: false);

    print(contacts);
  }
}
