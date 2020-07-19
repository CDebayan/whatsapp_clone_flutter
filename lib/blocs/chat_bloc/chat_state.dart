import 'package:equatable/equatable.dart';
import 'package:whatsappcloneflutter/models/user_chat_model.dart';

abstract class ChatState extends Equatable{
  final List<UserChatList> chatList;
  const ChatState(this.chatList);
  @override
  List<Object> get props => [chatList];
}

class Loading extends ChatState{
  Loading(List<UserChatList> chatList) : super(chatList);
}

class Loaded extends ChatState{
  Loaded(List<UserChatList> chatList) : super(chatList);
}