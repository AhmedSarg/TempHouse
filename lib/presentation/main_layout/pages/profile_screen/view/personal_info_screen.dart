import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/common/widget/main_text_field.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.personalInfoTitle.tr(),
          style: AppTextStyles.profileInfoTitle(context),
        ),
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: Text(AppStrings.personalInfoSubTitleInformation.tr(),style: AppTextStyles.profileInfoSubTitle(context),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s8),border: Border.all(color: Colors.white)),

                    child: MainTextField(
                        backgroundColor: Colors.transparent,
                        hint: AppStrings.personalInfoSubTitleInformationFirstHint.tr())),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s8),border: Border.all(color: Colors.white)),
                    
                    child: MainTextField(
                        backgroundColor: Colors.transparent,
                        hint: AppStrings.personalInfoSubTitleInformationSecondHint.tr())),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: Text(AppStrings.personalInfoSubTitleContact.tr(),style: AppTextStyles.profileInfoSubTitle(context)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s8),border: Border.all(color: Colors.white)),

                    child: MainTextField(
                        backgroundColor: Colors.transparent,
                        hint: AppStrings.personalInfoSubTitleContactHint.tr())),
              ),
            ],
          ),
SizedBox(height: AppSize.s30,),
          Center(
            child: MainButton(backgroundColor: ColorManager.offwhite,text: AppStrings.personalInfoBtn.tr(), textStyle: AppTextStyles.personalInfoBtn(context), onTap: () {  },),
          )
        ],
      ),
    );
  }
}
