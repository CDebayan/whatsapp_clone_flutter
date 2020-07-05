import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/models/contact_list_model.dart';
import 'package:whatsappcloneflutter/models/general_response.dart';
import 'package:whatsappcloneflutter/models/login_model.dart';
import 'package:whatsappcloneflutter/models/user_details_model.dart';
import 'package:whatsappcloneflutter/models/user_list_model.dart';

import 'dio_client.dart';

class DioServices {
  static Future<LoginModel> login(
      {@required String countryCode,
      @required String mobileNo,
      @required String deviceId,
      @required String platform}) async {
    String fcmToken = await FirebaseMessaging().getToken();
    try {
      FormData formData = FormData.fromMap({
        "countryCode": countryCode,
        "mobileNo": mobileNo,
        "deviceId": deviceId,
        "platform": platform,
        "fcm": fcmToken
      });
      var response = await DioClient.postCall('user/login', formData: formData);
      return LoginModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError =await  error(e);
      return LoginModel(
          status: generalError.status, message: generalError.message);
    }
  }

  static Future<UserListModel> getUserList(List<ContactListModel> contactList) async {
    try {
      var response = await DioClient.postCall('user/userList',
          bodyData: {'contactList': contactList});
      return UserListModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError =await  error(e);
      if(generalError.status == "401"){
        var response = await getUserList(contactList);
        return response;
      }
      return UserListModel(status: generalError.status, message: generalError.message);
    }
  }

  static Future<UserDetailsModel> getUserDetails() async {
    try {
      var response = await DioClient.getCall('user/userDetails');
      return UserDetailsModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError = await error(e);
      if(generalError.statusCode == 401){
        var response = await getUserDetails();
        return response;
      }
      return UserDetailsModel(status: generalError.status, message: generalError.message);
    }
  }

  static Future<UserDetailsModel> updateName(String name) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
      });
      var response = await DioClient.patchCall('user/updateName',formData: formData);
      return UserDetailsModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError = await error(e);
      if(generalError.statusCode == 401){
        var response = await updateName(name);
        return response;
      }
      return UserDetailsModel(status: generalError.status, message: generalError.message);
    }
  }

  static Future<UserDetailsModel> updateAbout(String about) async {
    try {
      FormData formData = FormData.fromMap({
        "about": about,
      });
      var response = await DioClient.patchCall('user/updateAbout',formData: formData);
      return UserDetailsModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError = await error(e);
      if(generalError.statusCode == 401){
        var response = await updateAbout(about);
        return response;
      }
      return UserDetailsModel(status: generalError.status, message: generalError.message);
    }
  }

  static Future<GeneralResponse> refreshToken() async {
    var response = await DioClient.getCall('refreshToken');
    return GeneralResponse.fromJson(response);
  }
}
