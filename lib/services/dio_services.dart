import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatsappcloneflutter/models/login_model.dart';

import 'dio_client.dart';

class DioServices {
  static Future<LoginModel> login({String countryCode,String mobileNo, String deviceId, String platform}) async {
    String fcmToken = await  FirebaseMessaging().getToken();
    try {
      FormData formData = FormData.fromMap({
        "countryCode": countryCode,
        "mobileNo": mobileNo,
        "deviceId": deviceId,
        "platform": platform,
        "fcm" : fcmToken
      });
      var response = await DioClient.postCall('user/login', formData: formData);
      return LoginModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError = error(e);
      return LoginModel(
          status: generalError.status, message: generalError.message);
    }
  }
}
