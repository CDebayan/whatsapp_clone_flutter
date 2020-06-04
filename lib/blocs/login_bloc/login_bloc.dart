import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_number/phone_number.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_event.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_state.dart';
import 'package:whatsappcloneflutter/country_picker/country_model.dart';
import 'package:whatsappcloneflutter/country_picker/country_picker.dart';
import 'package:whatsappcloneflutter/functionality.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> with Functionality{
  final CountryPicker _countryPicker = CountryPicker();

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is SearchCountryByCodeEvent){
      yield* _mapSearchCountryByCodeEventToState(event);
    }else if(event is SelectCountryEvent){
      CountryModel countryModel = await _countryPicker.showScreen(event.context);
      yield SelectedCountryState(countryModel: countryModel);
    }else if(event is ValidationEvent){
      yield* _mapValidationEventToState(event);
    }else if(event is SetSimNumberEvent){
      yield* _mapSetSimNumberEventToState(event);
    }
  }

  Stream<LoginState> _mapSearchCountryByCodeEventToState(SearchCountryByCodeEvent event) async*{
    if (isValidString(event.code)) {
      CountryModel result = await _countryPicker.searchCountryByCode(event.code);
      if(isValidObject(result)){
        yield SelectedCountryState(countryModel: result);
      }else{
        yield SelectedCountryState(countryModel: CountryModel(name: "invalid country code"));
      }
    }else{
      yield SelectedCountryState(countryModel: CountryModel(name: ""));
    }
  }

  Stream<LoginState> _mapValidationEventToState(ValidationEvent event) async*{
    // TODO if ValidationState, previous and current state are same then not called (need to fix)
    yield LoadingState();
    if (event.countryCode.isEmpty) {
      yield ValidationState(status: "countryCodeError", message: "Invalid country code length(1-4 digits only).");
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

  Stream<LoginState> _mapSetSimNumberEventToState(SetSimNumberEvent event) async*{
    //  TODO if SetSimNumberState, previous and current state are same then not called (need to fix)
    yield LoadingState();
    CountryModel countryModel = await _countryPicker.searchCountryByCode(event.simCard.countryPhonePrefix);
    yield SetSimNumberState(countryModel: countryModel, phone: event.simCard.number.substring(event.simCard.number.length - 10));
  }

}