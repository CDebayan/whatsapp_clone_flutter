import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_event.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class SelectCountryBloc extends Bloc<SelectCountryEvent, SelectCountryState>
    with Functionality {
  final _appbarController = StreamController<bool>.broadcast();
  bool _appbarStatus = false;
  List<CountryModel> _countryList;

  Stream<bool> get showSearch => _appbarController.stream;

  bool get appbarStatus => _appbarStatus;

  void updateAppbarStatus() {
    _appbarStatus = !appbarStatus;
    _appbarController.sink.add(appbarStatus);
    add(SearchCountryEvent(text : ""));
  }

  @override
  SelectCountryState get initialState => InitialState();

  @override
  Stream<SelectCountryState> mapEventToState(SelectCountryEvent event) async* {
    if (event is FetchCountryListEvent) {
      yield LoadingState();
      CountryListModel result = await DioServices.getCountryList();
      if (isValidObject(result) &&
          isValidObject(result.status) &&
          isValidString(result.status) &&
          result.status == "true") {
        if (isValidList(result.countryList)) {
          _countryList = result.countryList;
          yield LoadedState(countryList: result.countryList);
        } else {
          yield EmptyListState();
        }
      } else {
        yield ErrorState();
      }
    } else if (event is SearchCountryEvent) {
      if (isValidList(_countryList)) {
        if (event.text.isNotEmpty) {
          List<CountryModel> _filteredCountryList = List<CountryModel>();
          _filteredCountryList = _countryList.where((element) {
            String text = event.text;
            String name = element.name;
            String code = element.callingCodes[0];
            return name.toLowerCase().contains(text.toLowerCase()) || code.toLowerCase().contains(text.toLowerCase());
          }).toList();
          yield LoadedState(countryList: _filteredCountryList);
        } else {
          yield LoadedState(countryList: _countryList);
        }
      }
    }
  }

  //              return event.text.toLowerCase().contains(element.name.toLowerCase()) ||
//                event.text
//                    .toLowerCase()
//                    .contains(element.callingCodes[0].toLowerCase());

  void dispose() {
    _appbarController?.close();
  }

}
