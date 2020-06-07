import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class VerifyPhoneEvent extends Equatable{
  const VerifyPhoneEvent();
}

class ValidateOtpEvent extends VerifyPhoneEvent{
  final String countryCode;
  final String mobileNo;
  final String otp;
  const ValidateOtpEvent({@required this.countryCode,@required this.mobileNo,@required this.otp});
  @override
  List<Object> get props => [countryCode,mobileNo,otp];

}