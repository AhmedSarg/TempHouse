import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key, this.controller, this.getImagesFromGallery, this.getImagesFromCamera, this.sendMessage});
  final TextEditingController? controller;
  final void Function()?  getImagesFromGallery;
  final void Function()?  getImagesFromCamera;
  final void Function()?  sendMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: ColorManager.offwhite),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                  vertical: AppMargin.m20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                height: AppSize.s50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20),
                  border: Border.all(color: ColorManager.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: ColorManager.offwhite,
                        style: AppTextStyles.chatNoMessageTextStyle(context),
                        controller: controller,
                        decoration: InputDecoration.collapsed(
                          hintText: AppStrings.chatScreenInputHint.tr(),
                          hintStyle:
                          AppTextStyles.chatTextFieldHintTextStyle(context),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: getImagesFromGallery,
                      icon: const Icon(Icons.image,
                          size: AppSize.s30, color: ColorManager.white),
                    ),
                    IconButton(
                      onPressed: getImagesFromCamera,
                      icon: const Icon(Icons.camera_alt,
                          size: AppSize.s30, color: ColorManager.white),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, size: AppSize.s30),
              color: ColorManager.white,
            ),
          ],
        ),
      ],
    );
  }
}
