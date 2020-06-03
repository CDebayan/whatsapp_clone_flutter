
import 'package:flutter/cupertino.dart';
import 'package:whatsappcloneflutter/country_picker/country_model.dart';

abstract class CountryListEvent{}

class FetchCountryList extends CountryListEvent{}

class SearchCountry extends CountryListEvent{
  final String text;

  SearchCountry(this.text);
}

class SelectCountry extends CountryListEvent{
  final CountryModel countryModel;
  final BuildContext context;

  SelectCountry(this.countryModel,this.context);
}