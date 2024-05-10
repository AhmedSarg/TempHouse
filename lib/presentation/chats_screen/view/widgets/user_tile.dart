// Update the UserTile widget in the ChatsScreen class
import 'package:flutter/material.dart';

import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String lastMessage;
  final String lastMessageTime;
  final void Function()? onTap;

  const UserTile({
    Key? key,
    required this.text,
    required this.lastMessage,
    required this.lastMessageTime,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:  AppPadding.p16),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          onTap: onTap,
          trailing: Text(lastMessageTime,style: AppTextStyles.chatsScreenLastMessageDateTextStyle(context),overflow: TextOverflow.ellipsis,),
          title: Text(text,style: AppTextStyles.chatsScreenUserNameTitleTextStyle(context),),
          subtitle: Text(lastMessage,style: AppTextStyles.chatsScreenLastMessageTextStyle(context),),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
// Container(
// child: Row(
// children: [
// const CircleAvatar(radius: AppSize.s30, child: Icon(Icons.person)),
// const SizedBox(width: AppSize.s10),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// text,
// style: AppTextStyles.chatsScreenTitleTextStyle(context),
// ),
// Text(
// lastMessage,
// style: TextStyle(color: Colors.grey),
// ),
// Text(
// lastMessageTime,
// style: TextStyle(color: Colors.grey),
// ),
// ],
// )
// ],
// ),
// )