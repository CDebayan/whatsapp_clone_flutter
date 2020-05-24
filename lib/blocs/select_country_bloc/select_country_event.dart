import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';

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



class SelectItemEvent extends SelectCountryEvent{
  final List<CountryModel> countryList;
  final int index;
  final BuildContext context;
  SelectItemEvent({@required this.countryList,@required this.index,@required this.context});

  @override
  List<Object> get props => [countryList,index,context];
}



