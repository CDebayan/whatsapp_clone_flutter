import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/general_response.dart';
import 'package:whatsappcloneflutter/services/dio_client.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class DioInterceptor extends Interceptor  with Functionality{
  @override
  Future onRequest(RequestOptions options) async{
    String accessToken = await getAccessToken();
    options.headers["Authorization"] = "Bearer $accessToken";
    options.baseUrl = DioClient.baseUrl;

    print("Request : ${options.method},${options.baseUrl}${options.path.toString()}");
    print("Request : ${options.headers.toString()}");
    print("Request : ${options.data.toString()}");
    return options;
  }

  @override
  Future onResponse(Response response) async{
    print("Response : ${response.request.method},${response.request.baseUrl}${response.request.path}");
    print("Response : ${response.toString()}");
    return response;
  }

  @override
  Future onError(DioError err) async{
    print("Error : $err");
    if(isValidObject(err.response) && isValidObject(err.response.statusCode) && err.response.statusCode == 401){
      GeneralResponse response = await DioServices.refreshToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.accessToken, response.message);
    }
    return err;
  }
}