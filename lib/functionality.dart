
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

mixin Functionality {

  bool isValidString(String value) {
    if (value == null || value.isEmpty || value == "null") {
      return false;
    }
    return true;
  }

  bool isValidObject(Object value) {
    if (value == null) {
      return false;
    }
    return true;
  }

  bool isValidList(List value) {
    if (value == null || value.isEmpty || value.length <= 0) {
      return false;
    }
    return true;
  }

  showToast({@required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  String codeToCountryEmoji(String code){
    final char1 = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final char2 = code.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(char1) + String.fromCharCode(char2);
  }
}
