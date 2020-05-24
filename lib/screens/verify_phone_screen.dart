import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class VerifyPhoneScreen extends StatelessWidget {
  static const String routeName = "VerifyPhoneScreen";

  static BuildContext _context;
  static String _number = "";

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: transparentAppBar(title: "Verify"),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              LinkText(_textList()),
              Text(
                "Enter 6-digit code",
                style: TextStyle(color: Constants.colorDefaultText),
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
              Divider(),
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
        )),
      ),
    );
  }

  List<TextSpanModel> _textList() {
    List<TextSpanModel> list = List<TextSpanModel>();
    list.add(
      TextSpanModel(
        text: "Waiting to automatically detect an SMS sent to $_number. ",
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
