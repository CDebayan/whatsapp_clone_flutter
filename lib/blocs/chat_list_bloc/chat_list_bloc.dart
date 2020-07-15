import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/chat_list_bloc/chat_list_event.dart';
import 'package:whatsappcloneflutter/blocs/chat_list_bloc/chat_list_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/chat_list_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';


class ChatListBloc extends Bloc<ChatListEvent,ChatListState> with Functionality{
  @override
  ChatListState get initialState => Loading();

  @override
  Stream<ChatListState> mapEventToState(ChatListEvent event) async*{
    if(event is FetchChatList){
      PermissionStatus status = await Permission.contacts.status;
      if(status == PermissionStatus.undetermined){
        yield RequiredPermission();
      }else if(status == PermissionStatus.granted){
        ChatListModel chatListModel =await DioServices.chatList();
        if(isValidObject(chatListModel) && isValidString(chatListModel.status) && chatListModel.status == "1"){
          yield LoadedChatList(chatListModel.chatList);
        }else{
          yield LoadedChatList(null);
        }
      }

    }

  }

}