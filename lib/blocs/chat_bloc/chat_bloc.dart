import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_event.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  @override
  ChatState get initialState => InitialState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async*{
    if(event is PermissionEvent){
      if(event.permissionStatus == PermissionStatus.undetermined){
        yield RequiredPermissionState();
      }else if(event.permissionStatus == PermissionStatus.granted){
        yield PermissionGrantedState();
      }

    }

  }

}