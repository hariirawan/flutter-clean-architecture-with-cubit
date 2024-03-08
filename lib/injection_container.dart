import 'package:cat_facts/data/repositories/breed_repository.dart';
import 'package:cat_facts/data/repositories/chat_repository.dart';
import 'package:cat_facts/data/services/breed_service.dart';
import 'package:cat_facts/data/services/chat_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<BreedRepository>(
      () => BreedRepository(BreedService()));
  getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepository(ChatService()));
}
