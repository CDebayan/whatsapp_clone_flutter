import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/country_picker/bloc/country_list_bloc.dart';
import 'package:whatsappcloneflutter/country_picker/country_model.dart';
import 'package:whatsappcloneflutter/country_picker/country_picker_screen.dart';
import 'package:whatsappcloneflutter/functionality.dart';

class CountryPicker with Functionality {
  CountryListBloc _bloc;

  CountryPicker() {
    _bloc = CountryListBloc();
    _bloc.fetchCountryList();
  }

  Future<CountryModel> showScreen(BuildContext context) async {
    CountryModel result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountryPickerScreen(_bloc)),
    );
    return result;
  }

  Future<CountryModel> searchCountryByCode(String code) async {
    if (!isValidList(_bloc.countryList)) {
      _bloc.fetchCountryList();
    }

    CountryModel countryModel = _bloc.countryList.singleWhere((element) {
      return element.callingCodes == code;
    }, orElse: () => null);
    if(isValidObject(countryModel)){
      _bloc.updateSelectedCountry(countryModel);
    }
    return countryModel;
  }
}
