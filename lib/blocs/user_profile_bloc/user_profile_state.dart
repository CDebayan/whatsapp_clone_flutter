import 'package:equatable/equatable.dart';
import 'package:whatsappcloneflutter/models/user_details_model.dart';

abstract class UserProfileState extends Equatable{
  const UserProfileState();
}

class InitialState extends UserProfileState{
  const InitialState();
  @override
  List<Object> get props => [];
}

class LoadingState extends UserProfileState{
  const LoadingState();
  @override
  List<Object> get props => [];
}

class LoadedState extends UserProfileState{
  final UserDetails  userDetails;
  const LoadedState(this.userDetails);
  @override
  List<Object> get props => [userDetails];
}