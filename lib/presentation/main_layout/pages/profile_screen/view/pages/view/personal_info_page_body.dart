import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/common/widget/main_image.dart';
import 'package:temp_house/presentation/common/widget/main_text_field.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/pages/viewmodel/personal_info_viewmodel.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../../common/widget/main_app_bar.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';

class PersonalInfoPageBody extends StatelessWidget {
  const PersonalInfoPageBody({super.key});

  static late PersonalInfoViewModel _viewModel;
  static final _emailFocusNode = FocusNode();
  static final _phoneNumberFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _viewModel = PersonalInfoViewModel.get(context);
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.personalInfoTitle.tr(),
          style: AppTextStyles.profileInfoTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p30),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                MainImage(
                  imageUrl: _viewModel.getImageChanged
                      ? _viewModel.getSelectedImage.path
                      : _viewModel.getImageUrl,
                  width: context.width() * .4,
                ),
                SizedBox(
                  width: context.width() * .4,
                  height: context.width() * .4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.transparent,
                      surfaceTintColor: ColorManager.black,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: _viewModel.chooseNewPicture,
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: MainTextField(
                    controller: _viewModel.getEmailController,
                    focusNode: _emailFocusNode,
                    nextFocus: _phoneNumberFocusNode,
                    backgroundColor: Colors.transparent,
                    hint: AppStrings.personalInfoEmailHint.tr(),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: MainTextField(
                    controller: _viewModel.getPhoneNumberController,
                    focusNode: _phoneNumberFocusNode,
                    backgroundColor: Colors.transparent,
                    hint: AppStrings.personalInfoPhoneNumberHint.tr(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s30),
            Center(
              child: MainButton(
                backgroundColor: ColorManager.offwhite,
                text: AppStrings.personalInfoBtn.tr(),
                textStyle: AppTextStyles.personalInfoBtn(context),
                onTap: _viewModel.update,
              ),
            )
          ],
        ),
      ),
    );
  }
}
