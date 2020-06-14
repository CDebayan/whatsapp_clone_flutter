import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable{
  const ChatState();
}

class InitialState extends ChatState{
  const InitialState();
  @override
  List<Object> get props => [];
}

class RequiredPermissionState extends ChatState{
  const RequiredPermissionState();
  @override
  List<Object> get props => [];
}

class PermissionGrantedState extends ChatState{
  const PermissionGrantedState();
  @override
  List<Object> get props => [];
}