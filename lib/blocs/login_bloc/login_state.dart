import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {}

class SelectedCountryState extends LoginState {
  final CountryModel countryModel;

  SelectedCountryState({@required this.countryModel});

  @override
  List<Object> get props => [countryModel];
}

class ValidationState extends LoginState {
  final String status;
  final String message;

  ValidationState({@required this.status, @required this.message});

  @override
  List<Object> get props => [status, message];
}
