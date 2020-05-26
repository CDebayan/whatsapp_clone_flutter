import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_number/phone_number.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_event.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_state.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_bloc.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_event.dart';
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
    }else if(event is ValidationEvent){
      yield* _mapValidationEventToState(event);
    }
  }

  Stream<LoginState> _mapSearchCountryByCodeEventToState(SearchCountryByCodeEvent event) async*{
    if (isValidString(event.code)) {
      List<CountryModel> _countryList = BlocProvider.of<SelectCountryBloc>(event.context).countryList;
      if (isValidList(_countryList)) {
        CountryModel countryModel = _countryList.singleWhere((element) {
                return element.callingCodes[0] == event.code;
              },orElse: () => CountryModel(name: "invalid country code"));
        BlocProvider.of<SelectCountryBloc>(event.context).add(SelectItemEvent(countryModel: countryModel,context: event.context));
        yield SelectedCountryState(countryModel: CountryModel(name: countryModel.name));
      }else{
        yield SelectedCountryState(countryModel: CountryModel(name: ""));
      }
    }else{
      yield SelectedCountryState(countryModel: CountryModel(name: ""));
    }
  }

  Stream<LoginState> _mapValidationEventToState(ValidationEvent event) async*{
    if (event.countryCode.isEmpty) {
      yield ValidationState(status: "countryCodeError", message: "Invalid country code length(1-3 digits only).");
    }else if(event.country == "invalid country code"){
      yield ValidationState(status: "countryError", message: "Invalid country code.");
    }else if(event.phone.isEmpty){
      yield ValidationState(status: "phoneError", message: "Please enter your phone number.");
    }else{
      try {
        final phoneValidation = await PhoneNumber().parse(event.phone, region: event.countryAlphaCode);
        yield ValidationState(status: "success", message: "");
      }on PlatformException catch (e) {
        yield ValidationState(status: "phoneError", message: "Invalid phone no.");
      }
    }
  }

}