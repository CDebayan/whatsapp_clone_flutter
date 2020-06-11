import 'package:device_info/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_event.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/login_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';
import 'dart:io';

class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent,VerifyPhoneState> with Functionality{
  @override
  VerifyPhoneState get initialState => InitialState();

  @override
  Stream<VerifyPhoneState> mapEventToState(VerifyPhoneEvent event) async*{
    if(event is ValidateOtpEvent){
      yield* _mapValidateOtpEventToState(event);
    }
  }

  Stream<VerifyPhoneState> _mapValidateOtpEventToState(ValidateOtpEvent event) async*{
    if(event.otp == "000000"){
      yield VerifyingState();
      AndroidDeviceInfo androidInfo =await DeviceInfoPlugin().androidInfo;
      LoginModel response = await DioServices.login(countryCode : event.countryCode,mobileNo: event.mobileNo,deviceId: androidInfo.androidId,platform: Platform.operatingSystem);
      if(isValidObject(response) && isValidString(response.status) && response.status == "1"){
        if(isValidString(response.accessToken)){
          updateAccessToken(response.accessToken);
        }
        yield VerifiedState();
      }else{
        yield VerificationFailedState();
      }
    }else{
      yield InvalidOtpState();
    }
  }

}