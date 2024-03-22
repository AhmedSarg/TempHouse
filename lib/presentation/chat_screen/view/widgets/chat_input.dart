import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorManager.secondary,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              cursorColor: ColorManager.secondary,
              style: AppTextStyles.chatScreenInputTextStyle(context),
              decoration: InputDecoration(
                hintText: AppStrings.chatScreenInputHint.tr(),
                hintStyle: AppTextStyles.chatScreenInputTextStyle(context),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: const BorderSide(
                    color: ColorManager.secondary,
                    width: AppSize.s1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: const BorderSide(
                    color: ColorManager.secondary,
                    width: AppSize.s1,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: ColorManager.secondary,
            ),
            onPressed: () {
              if (kDebugMode) {
                print(_textController.text);
              }
              _textController.clear();
            },
          ),
        ],
      ),
    );
  }
}
