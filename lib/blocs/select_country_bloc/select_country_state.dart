import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';

abstract class SelectCountryState extends Equatable{
  const SelectCountryState();

  @override
  List<Object> get props => [];
}

class InitialState extends SelectCountryState {}

class LoadingState extends SelectCountryState {}

class LoadedState extends SelectCountryState {
  final List<CountryModel> countryList;
  LoadedState({@required this.countryList});

  @override
  List<Object> get props => [countryList];
}

class EmptyListState extends SelectCountryState{}

class ErrorState extends SelectCountryState {}

