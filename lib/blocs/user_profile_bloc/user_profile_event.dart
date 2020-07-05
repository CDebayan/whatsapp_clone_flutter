import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable{
  const UserProfileEvent();
}

class FetchUserDetails extends UserProfileEvent{
  const FetchUserDetails();
  @override
  List<Object> get props => [];
}

class UpdateNameEvent extends UserProfileEvent{
  final String name;
  const UpdateNameEvent(this.name);
  @override
  List<Object> get props => [name];
}

class UpdateAboutEvent extends UserProfileEvent{
  final String about;
  const UpdateAboutEvent(this.about);
  @override
  List<Object> get props => [about];
}