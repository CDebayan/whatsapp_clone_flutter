import 'package:equatable/equatable.dart';
import 'package:whatsappcloneflutter/models/user_list_model.dart';

abstract class UserListState extends Equatable{
  const UserListState();
}

class InitialState extends UserListState{
  const InitialState();
  @override
  List<Object> get props => [];
}

class RequiredPermissionState extends UserListState{
  const RequiredPermissionState();
  @override
  List<Object> get props => [];
}

class LoadingState extends UserListState{
  const LoadingState();
  @override
  List<Object> get props => [];
}

class LoadedState extends UserListState{
  final List<UserModel> userModel;

  const LoadedState(this.userModel);
  @override
  List<Object> get props => [userModel];
}