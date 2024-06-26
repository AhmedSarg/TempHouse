import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/common/widget/main_image.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
      decoration: BoxDecoration(
          color: ColorManager.primary.withOpacity(.9),
          borderRadius: BorderRadius.circular(AppSize.s10)),
      child: ListTile(
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: ColorManager.grey,
        ),
        title: Text(
          DataIntent.getUser().username,
          style: AppTextStyles.profileInfoNameTextStyle(context),
        ),
        subtitle: Text(
          DataIntent.getUser().email,
          style: AppTextStyles.profileInfoEmailTextStyle(context),
        ),
        leading: MainImage(
          imageUrl: DataIntent.getUser().imageUrl,
          width: AppSize.s60,
        ),
      ),
    );
  }
}
