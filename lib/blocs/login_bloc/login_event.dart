import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class SearchCountryByCodeEvent extends LoginEvent{
  final String code;
  final BuildContext context;
  const SearchCountryByCodeEvent({@required this.code,@required this.context});

  @override
  List<Object> get props => [code,context];
}

class SelectedCountryEvent extends LoginEvent{
  final CountryModel countryModel;
  const SelectedCountryEvent({@required this.countryModel});

  @override
  List<Object> get props => [countryModel];
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