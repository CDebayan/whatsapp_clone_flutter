import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_event.dart';
import 'package:whatsappcloneflutter/blocs/chat_bloc/chat_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/user_chat_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState> with Functionality{
  @override
  ChatState get initialState => Loading(null);

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async*{
    if(event is FetchUserChat){
      yield* _mapFetchUserChatToState(event);
    }
  }

  Stream<ChatState> _mapFetchUserChatToState(FetchUserChat event) async*{
    UserChatModel response = await DioServices.userChat(event.userId);
    if(isValidObject(response) && isValidList(response.chatList)){
      yield Loaded(response.chatList);
    }else{
      yield Loaded(null);
    }

  }

}