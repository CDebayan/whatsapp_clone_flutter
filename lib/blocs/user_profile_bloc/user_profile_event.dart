import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable{
  const UserProfileEvent();
}

class FetchUserDetailsEvent extends UserProfileEvent{
  const FetchUserDetailsEvent();
  @override
  List<Object> get props => [];

}