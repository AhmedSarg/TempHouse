import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chats_screen/view/widgets/chats_item.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../chat_screen/view/widgets/no_message_screen.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/text_styles.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({
    super.key,
  });

  final ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.chatsScreenTitle.tr(),
          style: AppTextStyles.chatsScreenTitleTextStyle(context),
        ),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatServices.getUserStreamOrdered(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return NoContent(content: AppStrings.chatNoUsers.tr());
        } else {
          final List<Map<String, dynamic>> filteredUsers = snapshot.data!;
          return ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final userData = filteredUsers[index];

              final List participantsIds = userData['participants_ids'] as List;
              participantsIds.remove(DataIntent.getUser().uid);
              final String receiverId = participantsIds.first;

              final List participantsNames =
                  userData['participants_names'] as List;
              participantsNames.remove(DataIntent.getUser().username);
              final String receiverName = participantsNames.first;

              final Future<String?> chatImage = FirebaseFirestore.instance
                  .collection('users')
                  .doc(receiverId)
                  .get()
                  .then(
                    (value) => value.data()!['image_path'],
                  );
              final String chatID = userData['id'];

              return ChatsItem(
                name: receiverName,
                lastMessage: userData['last_message'],
                lastMessageDate: userData['last_message_date'].toDate(),
                image: chatImage,
                chatId: chatID,
                personId: receiverId,
              );
            },
          );
        }
      },
    );
  }
}
