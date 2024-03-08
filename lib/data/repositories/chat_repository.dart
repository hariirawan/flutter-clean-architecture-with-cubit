import 'package:cat_facts/data/models/chat.dart';
import 'package:cat_facts/data/services/chat_service.dart';

class ChatRepository {
  final ChatService service;

  ChatRepository(this.service);

  Future<Chat> fetchRandomFact(dynamic param) async {
    final response = await service.fetchRandomFact(param);

    if (response.isEmpty) {
      return Chat(fact: "No facts found for this parameter");
    }
    return chatFromJson(response);
  }
}
