import 'package:cat_facts/cubit/breed/breed_cubit.dart';
import 'package:cat_facts/cubit/chat/chat_cubit.dart';
import 'package:cat_facts/data/repositories/breed_repository.dart';
import 'package:cat_facts/data/repositories/chat_repository.dart';
import 'package:cat_facts/injection_container.dart';
import 'package:cat_facts/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => ChatCubit(getIt<ChatRepository>())),
        BlocProvider(create: (_) => BreedCubit(getIt<BreedRepository>())),
      ], child: const HomePage()),
    );
  }
}
