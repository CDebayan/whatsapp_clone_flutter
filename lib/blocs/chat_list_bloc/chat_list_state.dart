import 'package:equatable/equatable.dart';
import 'package:whatsappcloneflutter/models/chat_list_model.dart';

abstract class ChatListState extends Equatable{
  const ChatListState();
}

class Loading extends ChatListState{
  const Loading();
  @override
  List<Object> get props => [];
}

class RequiredPermission extends ChatListState{
  const RequiredPermission();
  @override
  List<Object> get props => [];
}

class LoadedChatList extends ChatListState{
  final List<ChatList> chatList;
  const LoadedChatList(this.chatList);
  @override
  List<Object> get props => [chatList];
}