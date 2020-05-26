import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:whatsappcloneflutter/services/dio_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio();
  static final String baseUrl = "http://192.168.0.5:3000/";

  static Dio _invoke(bool otherUrl) {
    if(!otherUrl){
      _dio.interceptors.add(DioInterceptor());
    }
    return _dio;
  }

  static getCall(String path, {Map<String, String> queryParameters,bool otherUrl = false}) async{
    Response response = await _invoke(otherUrl).get(path,queryParameters: queryParameters);
    if(response != null){
      if(response.data != null){
        if(response.data is String){
          return json.decode(response.data);
        }else if(response.data is Map){
          return response.data;
        }
      }
    }
    return null;
  }

  static postCall(String path, {Map<String, dynamic> bodyData,FormData formData,bool otherUrl = false}) async{
    Response response;
    if(bodyData != null && formData == null){
      response = await _invoke(otherUrl).post(path,data: bodyData);
    }else if(bodyData == null && formData != null){
      response = await _invoke(otherUrl).post(path,data: formData);
    }else if(bodyData == null && formData == null){
      response = await _invoke(otherUrl).post(path);
    }

    if(response != null){
      if(response.data != null){
        if(response.data is String){
          return json.decode(response.data);
        }else if(response.data is Map){
          return response.data;
        }
      }
    }
    return null;
  }
}

GeneralError error(DioError e){
  if (e.error is SocketException) {
    return GeneralError(status: "error", message: "You are not connected to internet");
  } else if (e.error is HttpException) {
    return GeneralError(status: "error", message: "Http Exception");
  } else if (e.error is FormatException) {
    return GeneralError(status: "error", message: "Format Exception");
  }else if(e.type is DioErrorType){
    return GeneralError(status: "error",statusCode: e.response.statusCode,message: e.message);
  }
  return GeneralError(status: "error", message: "Something went wrong");
}

class GeneralError{
  String status;
  int statusCode;
  String message;
  GeneralError({this.status,this.statusCode,this.message});
}
