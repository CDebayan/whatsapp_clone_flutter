import 'package:equatable/equatable.dart';

abstract class SelectCountryEvent extends Equatable {
  const SelectCountryEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryListEvent extends SelectCountryEvent{}

