import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsappcloneflutter/constants.dart';

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

  String codeToCountryEmoji(String code) {
    final char1 = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final char2 = code.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(char1) + String.fromCharCode(char2);
  }

  void updateAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessToken, token);
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.accessToken);
    if (token != null) {
      return token;
    } else {
      return "";
    }
  }

  Future<File> cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 70,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: true),
        iosUiSettings: IOSUiSettings(
            rotateButtonsHidden: true, rotateClockwiseButtonHidden: true));

    if (croppedFile == null) {
      return image;
    } else {
      return croppedFile;
    }
  }

  String convertTime(String time) {
    if (isValidString(time)) {
      return DateFormat('hh:mm').format(DateTime.parse(time));
    }else{
      return "";
    }
  }
}
