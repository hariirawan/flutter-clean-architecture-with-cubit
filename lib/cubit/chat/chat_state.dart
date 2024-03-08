part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;
  ChatLoaded(this.chats);
}

class ChatLoading extends ChatState {
  final List<Chat> oldChats;
  ChatLoading(this.oldChats);
}

class ChatFailure extends ChatState {
  final String message;

  ChatFailure(this.message);
}
