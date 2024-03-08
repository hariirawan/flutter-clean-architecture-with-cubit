import 'package:cat_facts/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_facts/data/models/chat.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  ChatCubit(this.repository) : super(ChatInitial());

  void addChat(dynamic param) {
    if (state is ChatLoading) return;

    final currentState = state;

    var chats = <Chat>[];

    if (currentState is ChatLoaded) {
      chats = currentState.chats;
    }

    emit(ChatLoading(chats));

    repository.fetchRandomFact(param).then((value) {
      final chats = (state as ChatLoading).oldChats;

      if (value.fact == "") {
        emit(ChatLoaded(chats));
        return;
      }

      chats.add(Chat(
          fact: value.fact, length: value.length, createdAt: DateTime.now()));
      emit(ChatLoaded(chats));
    }).catchError((onError) {
      emit(ChatFailure("Data tidak ditemukan"));
    });
  }

  void deleteChat(Chat chat) {
    final currentState = state;
    var chats = <Chat>[];

    if (currentState is ChatLoaded) {
      chats = currentState.chats;
    }
    chats.remove(chat);

    emit(ChatLoaded(chats));
  }
}
