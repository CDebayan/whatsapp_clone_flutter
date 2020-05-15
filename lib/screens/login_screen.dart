
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
import 'package:whatsappcloneflutter/screens/select_country_screen.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(title: "Enter your phone number"),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    LinkText(_textList()),
                    Container(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          EditText(
                            hint: "Choose a country",
                            controller: _countryController,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                              color: Constants.colorPrimaryDark,
                            ),
                            contentPadding: const EdgeInsets.only(
                                bottom: -20, left: 16, right: 16),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SelectCountryScreen.routeName);
                            },
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: EditText(
                                  hint: "",
                                  controller: _countryCodeController,
                                  prefixIcon: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Constants.colorDefaultText,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      bottom: -20, left: 20),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                  flex: 3,
                                  child: EditText(
                                    hint: "phone number",
                                    controller: _phoneController,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Button(text: "Next", onPressed: () {}),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpanModel> _textList() {
    List<TextSpanModel> list = List<TextSpanModel>();
    list.add(
      TextSpanModel(
        text: 'WhatsApp will send an SMS message to verify your phone number. ',
        color: Constants.colorBlack,
      ),
    );
    list.add(
      TextSpanModel(
        text: "What's my number?",
        onTap: () {},
      ),
    );
    return list;
  }

  AppBar transparentAppBar({String title = ""}) {
    return AppBar(
      title: Center(
          child: Text(
        title,
        style: TextStyle(color: Constants.colorPrimaryDark),
      )),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
