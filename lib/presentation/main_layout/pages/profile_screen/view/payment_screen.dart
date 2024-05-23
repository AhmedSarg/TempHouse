import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';
import '../../../../resources/values_manager.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.paymentScreenTitle.tr(),
          style: AppTextStyles.paymentAppBarTextStyle(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: ColorManager.grey, width: AppSize.s10)),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        SVGAssets.card,
                        width: AppSize.s75,
                        height: AppSize.s75,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                AppStrings.paymentNoCard.tr(),
                style: AppTextStyles.paymentNoCardTextStyle(context),
              )
            ],
          ),
          MainButton(
            backgroundColor: ColorManager.offwhite,
            text: AppStrings.paymentAddCardButton.tr(),
            textStyle: AppTextStyles.paymentBtnTextStyle(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.paymentScreenDetailsRoute);
            },
          )
        ],
      ),
    );
  }
}
