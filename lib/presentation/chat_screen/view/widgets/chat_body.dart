import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import 'chat_input.dart';
import 'chat_message.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p20,
              horizontal: AppPadding.p8,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ChatMessage(
                message: 'Message ${index + 1}',
                isSentByMe: index % 2 == 0,
              );
            },
          ),
        ),
        const ChatInput(),
      ],
    );
  }
}
