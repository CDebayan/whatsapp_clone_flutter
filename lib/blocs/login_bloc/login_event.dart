import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_number/mobile_number.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class SearchCountryByCodeEvent extends LoginEvent{
  final String code;
  const SearchCountryByCodeEvent({@required this.code});

  @override
  List<Object> get props => [code];
}

class SelectCountryEvent extends LoginEvent{
  final BuildContext context;
  const SelectCountryEvent({@required this.context});

  @override
  List<Object> get props => [context];
}

class SetSimNumberEvent extends LoginEvent{
  final SimCard simCard;
  const SetSimNumberEvent({@required this.simCard});

  @override
  List<Object> get props => [simCard];
}


class ValidationEvent extends LoginEvent {
  final String countryCode;
  final String countryAlphaCode;
  final String country;
  final String phone;

  ValidationEvent(
      {@required this.countryCode,
      @required this.countryAlphaCode,
        @required this.country,
        @required this.phone});

  @override
  List<Object> get props => [countryCode,countryAlphaCode,country,phone];
}