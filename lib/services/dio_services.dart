import 'package:dio/dio.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';

import 'dio_client.dart';

class DioServices {
  static Future<CountryListModel> getCountryList() async {
    try {
      var response = await DioClient.getCall('externalApi/countryList');
      CountryListModel loginResponse = CountryListModel.fromJson(response);
      return loginResponse;
    } on DioError catch (e) {
      GeneralError generalError = error(e);
      return CountryListModel(status: generalError.status, message: generalError.message);
    }
  }
}

