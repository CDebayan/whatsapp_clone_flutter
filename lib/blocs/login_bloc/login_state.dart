import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/country_picker/country_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SelectedCountryState extends LoginState {
  final CountryModel countryModel;

  SelectedCountryState({@required this.countryModel});

  @override
  List<Object> get props => [countryModel];
}

class SetSimNumberState extends LoginState {
  final CountryModel countryModel;
  final String phone;

  SetSimNumberState({@required this.countryModel,@required this.phone});

  @override
  List<Object> get props => [countryModel,phone];
}

class ValidationState extends LoginState {
  final String status;
  final String message;

  ValidationState({@required this.status, @required this.message});

  @override
  List<Object> get props => [status, message];
}
