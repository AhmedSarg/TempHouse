import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chat_screen/view/chat_view.dart';
import 'package:temp_house/presentation/chats_screen/view/widgets/user_tile.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../chat_screen/view/widgets/no_message_screen.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/text_styles.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);

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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _chatServices.getUserStreamOrdered(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return NoContent(content: AppStrings.chatNoUsers.tr());
        }
        final filteredUsers = snapshot.data!.docs;

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final userData = filteredUsers[index].data();
            // Here, you should extract necessary user data and pass it to ListTile.
            // For example, assuming your user data has fields 'userID', 'email', and 'chatID':
            final userID = userData['userID'];
            final userEmail = userData['email'];
            final chatID = userData['chatID'];

            return ListTile(
              title: Text(userEmail), // Display user's email or name here
              subtitle: Text('Subtitle'), // Display additional info if needed
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ChatScreen(
                      receiveID: userID,
                      receiveEmail: userEmail,
                      chatID: chatID,
                    );
                  }),
                );
              },
            );
          },
        );
      },
    );
  }
}
