import 'package:equatable/equatable.dart';

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