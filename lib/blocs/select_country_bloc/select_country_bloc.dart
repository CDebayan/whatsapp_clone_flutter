import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_bloc.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_event.dart';
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


  List<CountryModel> get countryList => _countryList;

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
      yield* _mapFetchCountryListEventToState();
    }else if(event is SelectItemEvent){
      yield* _mapSelectItemEventToState(event);
    } else if (event is SearchCountryEvent) {
      yield* _mapSearchCountryEventToState(event);
    }

  }

  Stream<SelectCountryState> _mapSearchCountryEventToState(SearchCountryEvent event) async*{
    if (isValidList(_countryList)) {
      if (event.text.isNotEmpty) {
        var _filteredCountryList = _countryList.where((element) {
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

  Stream<SelectCountryState> _mapSelectItemEventToState(SelectItemEvent event) async*{
    final currentState = state;
    for(int i = 0; i< _countryList.length;i++){
        _countryList[i].selected = false;
    }
    event.countryList[event.index].selected = true;

    if(currentState is LoadedState){
      BlocProvider.of<LoginBloc>(event.context).add(SelectedCountryEvent(countryModel: event.countryList[event.index]));
      yield LoadingState();
      yield LoadedState(countryList: event.countryList);
    }

  }

  Stream<SelectCountryState> _mapFetchCountryListEventToState() async* {
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
  }




  void dispose() {
    _appbarController?.close();
  }



}
