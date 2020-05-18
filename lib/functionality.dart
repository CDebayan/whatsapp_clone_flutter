
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

mixin Functionality {
  List validatePhone(String phone) {
    List list = List(2);
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (phone.isEmpty) {
      list[0] = false;
      list[1] = 'Please enter phone';
      return list;
    } else if (!regExp.hasMatch(phone)) {
      list[0] = false;
      list[1] = 'Please enter valid phone';
      return list;
    } else {
      list[0] = true;
      list[1] = null;
      return list;
    }
  }

  List validatePassword(String password) {
    List list = List(2);
    if (password.isEmpty) {
      list[0] = false;
      list[1] = 'Please enter password';
      return list;
    } else if (password.length < 4) {
      list[0] = false;
      list[1] = 'Password length should be greater than 3';
      return list;
    } else {
      list[0] = true;
      list[1] = null;
      return list;
    }
  }

//  List validateEmail(String email) {
//    List list = List(2);
//    if (email.isEmpty) {
//      list[0] = false;
//      list[1] = 'Please enter email';
//      return list;
//    } else if (!EmailValidator.validate(email)) {
//      list[0] = false;
//      list[1] = 'Please enter valid email';
//      return list;
//    } else {
//      list[0] = true;
//      list[1] = null;
//      return list;
//    }
//  }

//  void updateAccessToken(String token) async {
//    if (token != null) {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      await prefs.setString(Constants.accessToken, token);
//    }
//  }
//
//  Future<String> getAccessToken() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString(Constants.accessToken);
//    if (token != null) {
//      return token;
//    } else {
//      return "";
//    }
//  }

//  Future<bool> isUserLoggedIn() async {
//    String accessToken = await getAccessToken();
//    if (accessToken == "" || accessToken == null) {
//      return false;
//    } else {
//      return true;
//    }
//  }

//  void clearDataForLogout() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setString(Constants.accessToken, null);
//  }

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
}
