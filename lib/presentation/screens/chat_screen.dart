import 'package:cat_facts/cubit/chat/chat_cubit.dart';
import 'package:cat_facts/data/models/chat.dart';
import 'package:cat_facts/presentation/widgets/card_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();

  late String text;

  @override
  Widget build(BuildContext context) {
    final ChatCubit chatCubit = BlocProvider.of<ChatCubit>(context);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  List<Chat> chats = [];

                  if (state is ChatLoading) {
                    chats = state.oldChats.reversed.toList();
                  } else if (state is ChatLoaded) {
                    chats = state.chats.reversed.toList();
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: chats.length,
                      itemBuilder: ((context, index) {
                        Chat chat = chats[index];

                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          onDismissed: (DismissDirection direction) {
                            chatCubit.deleteChat(chat);
                          },
                          child: CardChat(chat: chat),
                        );
                      }));
                },
              ),
            ),
            Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3))
                ]),
                child: TextFormField(
                  controller: textEditingController,
                  onChanged: (value) {
                    setState(() {
                      text = value;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: "Type here...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      suffixIcon: BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          if (state is ChatLoading) {
                            return Container(
                              child: Center(child: CircularProgressIndicator()),
                              height: 10.0,
                              width: 10.0,
                            );
                          } else {
                            return IconButton(
                              onPressed: () {
                                chatCubit.addChat(text);
                                textEditingController.clear();
                              },
                              icon: const Icon(Icons.send),
                            );
                          }
                        },
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
