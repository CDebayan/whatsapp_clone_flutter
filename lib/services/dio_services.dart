import 'package:dio/dio.dart';
import 'package:whatsappcloneflutter/models/login_model.dart';

import 'dio_client.dart';

class DioServices {
  static Future<LoginModel> login({String countryCode,String mobile, String id, String platform}) async {
    try {
      FormData formData = FormData.fromMap({
        "countryCode": countryCode,
        "mobile": mobile,
        "id": id,
        "platform": platform,
      });
      var response = await DioClient.postCall('login', formData: formData);
      return LoginModel.fromJson(response);
    } on DioError catch (e) {
      GeneralError generalError = error(e);
      return LoginModel(
          status: generalError.status, message: generalError.message);
    }
  }
}
