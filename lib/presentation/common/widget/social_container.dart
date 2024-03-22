import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class SocialContainer extends StatelessWidget {
  const SocialContainer({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s24),
        color: ColorManager.darkGrey.withOpacity(.15),
      ),
      child: TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: SvgPicture.asset(image),
              ),
            ),
            Text(
              title,
              style: AppTextStyles.authSocialTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
