import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class NoHomesAvailable extends StatelessWidget {
  const NoHomesAvailable({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSize.s280,
        height: AppSize.s280,
        decoration: BoxDecoration(
          color: ColorManager.transparent,

        ),
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSize.s50,),
              Text(
                text,style: AppTextStyles.nearHomeNameTextStyle(context),),
            ],
          ),

        ),
      ),
    );
  }
}
