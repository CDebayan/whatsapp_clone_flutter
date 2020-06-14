import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class UserListEvent extends Equatable{
  const UserListEvent();
}

class PermissionEvent extends UserListEvent {
  final PermissionStatus permissionStatus;

  const PermissionEvent(this.permissionStatus);

  @override
  List<Object> get props => [permissionStatus];
}
