import 'package:device_info/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_event.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_state.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';
import 'dart:io';

class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent,VerifyPhoneState>{
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
      DioServices.login(countryCode : event.countryCode,mobile: event.mobileNo,id: androidInfo.androidId,platform: Platform.operatingSystem);
    }else{
      yield InvalidOtpState();
    }
  }

}