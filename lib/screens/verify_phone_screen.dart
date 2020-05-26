import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class VerifyPhoneScreen extends StatelessWidget {
  static const String routeName = "VerifyPhoneScreen";

  static BuildContext _context;
  static String _phoneNo;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _phoneNo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: transparentAppBar(title: "Verify $_phoneNo"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                LinkText(_textList()),
                TextField(),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Enter 6-digit code",
                  style: TextStyle(color: Constants.colorDefaultText),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.message,
                      color: Constants.colorDefaultText,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Text(
                      "Resend SMS",
                      style: TextStyle(
                          color: Constants.colorDefaultText,
                          fontWeight: FontWeight.bold),
                    )),
                    Text(
                      "1:02",
                      style: TextStyle(
                        color: Constants.colorDefaultText,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.call,
                      color: Constants.colorDefaultText,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Text(
                      "Call me",
                      style: TextStyle(
                          color: Constants.colorDefaultText,
                          fontWeight: FontWeight.bold),
                    )),
                    Text(
                      "1:02",
                      style: TextStyle(
                        color: Constants.colorDefaultText,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpanModel> _textList() {
    List<TextSpanModel> list = List<TextSpanModel>();
    list.add(
      TextSpanModel(
        text: "Waiting to automatically detect an SMS sent to $_phoneNo. ",
        color: Constants.colorBlack,
      ),
    );
    list.add(
      TextSpanModel(
        text: "Wrong number?",
        onTap: () {
          Navigator.of(_context).pop();
        },
      ),
    );
    return list;
  }
}
