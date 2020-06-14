import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class PermissionEvent extends ChatEvent {
  final PermissionStatus permissionStatus;

  const PermissionEvent(this.permissionStatus);

  @override
  List<Object> get props => [permissionStatus];
}
