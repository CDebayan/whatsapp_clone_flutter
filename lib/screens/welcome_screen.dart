
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/funtionality/functionality.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
import 'package:whatsappcloneflutter/screens/login_screen.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget with Functionality{
  static const String routeName = "WelcomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          color: Constants.colorWhite,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome to WhatsApp",
                style:
                    TextStyle(color: Constants.colorPrimaryDark, fontSize: 30),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Image(
                  image: AssetImage(Constants.welcome),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              LinkText(_textList()),
              SizedBox(
                height: 8,
              ),
              Button(
                text: "AGREE AND CONTINUE",
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                },
                padding: EdgeInsets.only(left: 40, right: 40),
              ),
              SizedBox(
                height: 50,
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpanModel> _textList() {
    List<TextSpanModel> list = List<TextSpanModel>();
    list.add(
      TextSpanModel(text: 'Read our '),
    );
    list.add(
      TextSpanModel(
        text: 'Privacy Ploicy',
        onTap: () {
          launchURL("https://www.whatsapp.com/legal/?lang=en#privacy-policy");
        },
      ),
    );
    list.add(
      TextSpanModel(text: '. Tap "Agree and continue" to accept the '),
    );
    list.add(
      TextSpanModel(
        text: 'Terms of Service.',
        onTap: () {
          launchURL("https://www.whatsapp.com/legal/?lang=en#terms-of-service");
        },
      ),
    );
    return list;
  }
}
