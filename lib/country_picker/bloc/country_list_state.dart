import 'package:whatsappcloneflutter/country_picker/country_model.dart';

abstract class CountryListState{}

class InitialState extends CountryListState{}

class LoadingState extends CountryListState{}

class LoadedState extends CountryListState{
  List<CountryModel> countryList;

  LoadedState(this.countryList);
}
