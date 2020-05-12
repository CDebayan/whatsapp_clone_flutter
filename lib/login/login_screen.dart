import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/widgets/model/text_span_model.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    suffixIcon: Icon(Icons.add, size: 16,color: Constants.defaultTextColor,),
                    contentPadding: const EdgeInsets.only(bottom: -20,left: 16,right: 16),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: EditText(
                          hint: "",
                          controller: _countryCodeController,
                          prefixIcon: Icon(Icons.add, size: 16,color: Constants.defaultTextColor,),
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
}
