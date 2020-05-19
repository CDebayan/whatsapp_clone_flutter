import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SelectCountryEvent extends Equatable {
  const SelectCountryEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryListEvent extends SelectCountryEvent{}

class SearchCountryEvent extends SelectCountryEvent{
  final String text;
  SearchCountryEvent({@required this.text});

  @override
  List<Object> get props => [text];
}

