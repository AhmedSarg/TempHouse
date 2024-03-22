import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/values_manager.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatMessage({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppMargin.m10,
        horizontal: AppMargin.m10,
      ),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p16,
        ),
        decoration: BoxDecoration(
          color: isSentByMe ? ColorManager.secondary : ColorManager.transparent,
          borderRadius: BorderRadius.circular(AppSize.s20),
          border: !isSentByMe
              ? Border.all(
                  color: ColorManager.secondary,
                  width: AppSize.s1,
                )
              : null,
        ),
        child: Text(
          message,
          style: AppTextStyles.chatScreenMessageTextStyle(
            context,
            isSentByMe ? ColorManager.primary : ColorManager.secondary,
          ),
        ),
      ),
    );
  }
}
