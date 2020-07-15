import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
}

class FetchChatList extends ChatListEvent {
  const FetchChatList();

  @override
  List<Object> get props => [];
}
