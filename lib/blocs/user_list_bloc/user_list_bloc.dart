import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_event.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent,UserListState>{
  @override
  UserListState get initialState => InitialState();

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async*{
    if(event is PermissionEvent){
      if(event.permissionStatus == PermissionStatus.granted){
        yield LoadingState();
      }else{
        yield RequiredPermissionState();
      }

    }

  }

}