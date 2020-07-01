import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/models/general_response.dart';
import 'package:whatsappcloneflutter/services/dio_interceptor.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class DioClient {
  static final Dio _dio = Dio();
  static final String baseUrl = "http://192.168.0.5:4000/";

  static Dio _invoke() {
    _dio.interceptors.add(DioInterceptor());
    return _dio;
  }

  static getCall(String path,
      {Map<String, String> queryParameters}) async {
    Response response =
        await _invoke().get(path, queryParameters: queryParameters);
    if (response != null) {
      if (response.data != null) {
        if (response.data is String) {
          return json.decode(response.data);
        } else if (response.data is Map) {
          return response.data;
        }
      }
    }
    return null;
  }

  static postCall(String path,
      {Map<String, dynamic> bodyData,
      FormData formData}) async {
    Response response;
    if (bodyData != null && formData == null) {
      response = await _invoke().post(path, data: bodyData);
    } else if (bodyData == null && formData != null) {
      response = await _invoke().post(path, data: formData);
    } else if (bodyData == null && formData == null) {
      response = await _invoke().post(path);
    }

    if (response != null) {
      if (response.data != null) {
        if (response.data is String) {
          return json.decode(response.data);
        } else if (response.data is Map) {
          return response.data;
        }
      }
    }
    return null;
  }

  static deleteCall(String path, {Map<String, String> queryParameters}) async {
    Response response =
        await _invoke().delete(path, queryParameters: queryParameters);
    if (response != null) {
      if (response.data != null) {
        if (response.data is String) {
          return json.decode(response.data);
        } else if (response.data is Map) {
          return response.data;
        }
      }
    }
    return null;
  }

  static putCall(String path, {Map<String, dynamic> bodyData}) async {
    Response response;
    if (bodyData != null) {
      response = await _invoke().put(path, data: bodyData);
    } else {
      response = await _invoke().put(path);
    }

    if (response != null) {
      if (response.data != null) {
        if (response.data is String) {
          return json.decode(response.data);
        } else if (response.data is Map) {
          return response.data;
        }
      }
    }
    return null;
  }

  static patchCall(String path, {FormData formData}) async {
    Response response =
        await _invoke().patch(path, data: formData);
    if (response != null) {
      if (response.data != null) {
        if (response.data is String) {
          return json.decode(response.data);
        } else if (response.data is Map) {
          return response.data;
        }
      }
    }
    return null;
  }
}

Future<GeneralError> error(DioError e) async {
  if (e.error is SocketException) {
    return GeneralError(
        status: "internetError", message: "You are not connected to internet");
  } else if (e.error is HttpException) {
    return GeneralError(status: "error", message: "Http Exception");
  } else if (e.error is FormatException) {
    return GeneralError(status: "error", message: "Format Exception");
  } else if (e.type is DioErrorType) {
    if (e.response != null &&
        e.response.statusCode != null &&
        e.response.statusCode == 401) {
      GeneralResponse response = await DioServices.refreshToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.accessToken, response.message);
      return GeneralError(statusCode: e.response.statusCode);
    }
    return GeneralError(
        statusCode: e.response.statusCode, status: "error", message: e.message);
  }
  return GeneralError(status: "error", message: "Something went wrong");
}

class GeneralError {
  int statusCode;
  String status;
  String message;

  GeneralError({this.statusCode, this.status, this.message});
}
