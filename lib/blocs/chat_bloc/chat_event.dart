import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable{
  const ChatEvent();
  @override
  List<Object> get props => [];
}

class FetchUserChat extends ChatEvent{
  final int userId;
  const FetchUserChat(this.userId);
  @override
  // TODO: implement props
  List<Object> get props => [userId];
}