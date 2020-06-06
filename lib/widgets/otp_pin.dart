import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsappcloneflutter/constants.dart';

class OtpPin extends StatefulWidget {
  @override
  _OtpPinState createState() => _OtpPinState();
}

class _OtpPinState extends State<OtpPin> {
  List<TextEditingController> controller = [
    TextEditingController(text: " __"),
    TextEditingController(text: " __"),
    TextEditingController(text: " __"),
    TextEditingController(text: " __"),
    TextEditingController(text: " __"),
    TextEditingController(text: " __"),
  ];

  List<FocusNode> focusNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              textField(0),
              textField(1),
              textField(2),
              SizedBox(
                width: 16,
              ),
              textField(3),
              textField(4),
              textField(5),
            ],
          ),
          Divider(
            thickness: 2,
            color: Constants.colorPrimaryDark,
          ),
        ],
      ),
    );
  }

  textField(int index) {
    return Container(
      width: 20,
      child: TextField(
        focusNode: focusNode[index],
        controller: controller[index],
        enableInteractiveSelection: false,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (containsNumber(value)) {
            controller[index].text = value.trim().replaceAll("_", "");
            if (index != 5) {
              FocusScope.of(context).requestFocus(focusNode[index + 1]);
              controller[index + 1].text = " __";
              controller[index + 1].selection = TextSelection.fromPosition(
                TextPosition(offset: 1),
              );
            }
          } else if (value.isEmpty) {
            controller[index].text = " __";
          } else {
            controller[index].text = " __";
            if (index != 0) {
              FocusScope.of(context).requestFocus(focusNode[index - 1]);
              controller[index - 1].text = " __";
              controller[index - 1].selection = TextSelection.fromPosition(
                TextPosition(offset: 1),
              );
            }
          }
          controller[index].selection = TextSelection.fromPosition(
            TextPosition(offset: 1),
          );
        },
        onTap: () {
          if (controller[index].text == " __") {
            for (int i = 0; i < controller.length; i++) {
              if (controller[i].text == " __") {
                FocusScope.of(context).requestFocus(focusNode[i]);
                controller[i].text = " __";
                controller[i].selection = TextSelection.fromPosition(
                  TextPosition(offset: 1),
                );
                break;
              }
            }
          }else{
            controller[index].selection = TextSelection.fromPosition(
              TextPosition(offset: 1),
            );
          }
        },
        decoration: InputDecoration(
            hintText: "__",
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: -20)),
      ),
    );
  }

  bool containsNumber(String value) {
    if (value.length != 1) {
      RegExp _numeric = RegExp(r'^-?[0-9]+$');

      for (int i = 0; i < value.length; i++) {
        if (_numeric.hasMatch(value[i])) {
          return true;
        }
      }
    }
    return false;
  }

  bool isNumber(String value) {
    if (value.length == 1) {
      RegExp _numeric = RegExp(r'^-?[0-9]+$');
      return _numeric.hasMatch(value);
    }
    return false;
  }
}
