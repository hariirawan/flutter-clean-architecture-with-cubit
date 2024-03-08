import 'package:cat_facts/data/models/chat.dart';
import 'package:flutter/material.dart';

class CardChat extends StatelessWidget {
  const CardChat({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.60),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0)),
            color: Colors.grey[300]),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat.fact,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              chat.createdAt.toString().substring(0, 16),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
