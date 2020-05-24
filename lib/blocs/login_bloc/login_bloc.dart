import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_event.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_state.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_bloc.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> with Functionality{
  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is SearchCountryByCodeEvent){
      yield* _mapSearchCountryByCodeEventToState(event);
    }else if(event is SelectedCountryEvent){
      yield SelectedCountryState(countryModel: event.countryModel);
    }
  }

  Stream<LoginState> _mapSearchCountryByCodeEventToState(SearchCountryByCodeEvent event) async*{
    if (isValidString(event.code)) {
      List<CountryModel> _countryList = BlocProvider.of<SelectCountryBloc>(event.context).countryList;
      if (isValidList(_countryList)) {
        CountryModel countryModel = _countryList.singleWhere((element) {
                return element.callingCodes[0] == event.code;
              },orElse: () => CountryModel(name: "invalid country code"));
        yield SelectedCountryState(countryModel: CountryModel(name: countryModel.name));
      }else{
        yield SelectedCountryState(countryModel: CountryModel(name: ""));
      }
    }else{
      yield SelectedCountryState(countryModel: CountryModel(name: ""));
    }
  }

}