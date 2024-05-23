import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/register_field_dialog.dart';
import '../../../common/widget/social_container.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/register_viewmodel.dart';

class RegisterTenantBody extends StatelessWidget {
  RegisterTenantBody({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode jobFocusNode = FocusNode();
  final FocusNode salaryFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode martialStatusFocusNode = FocusNode();

  final genderList = [
    AppStrings.registerScreenGenderMale.tr(),
    AppStrings.registerScreenGenderFemale.tr(),
  ];

  final martialStatusList = [
    AppStrings.registerScreenMartialStatusSingle.tr(),
    AppStrings.registerScreenMartialStatusMarried.tr(),
    AppStrings.registerScreenMartialStatusSeperated.tr(),
    AppStrings.registerScreenMartialStatusDivorced.tr(),
    AppStrings.registerScreenMartialStatusWidowed.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getUsernameController,
                focusNode: usernameFocusNode,
                nextFocus: emailFocusNode,
                label: AppStrings.registerScreenUsernameLabel.tr(),
                validation: AppValidators.validateUsername,
                isObscured: false,
                hint: AppStrings.registerScreenUsernameHint.tr(),
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getEmailController,
                focusNode: emailFocusNode,
                nextFocus: passwordFocusNode,
                label: AppStrings.registerScreenEmailLabel.tr(),
                isObscured: false,
                validation: AppValidators.validateEmail,
                hint: AppStrings.registerScreenEmailHint.tr(),
                textInputType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getPasswordController,
                focusNode: passwordFocusNode,
                nextFocus: phoneNumberFocusNode,
                label: AppStrings.registerScreenPasswordLabel.tr(),
                isObscured: true,
                validation: AppValidators.validatePassword,
                hint: AppStrings.registerScreenPasswordHint.tr(),
                iconData: Icons.remove_red_eye_outlined,
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getPhoneNumberController,
                focusNode: phoneNumberFocusNode,
                nextFocus: genderFocusNode,
                label: AppStrings.registerScreenPhoneNumberLabel.tr(),
                isObscured: false,
                validation: AppValidators.validatePhoneNumber,
                hint: AppStrings.registerScreenPhoneNumberHint.tr(),
                textInputType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getGenderController,
                focusNode: genderFocusNode,
                nextFocus: jobFocusNode,
                label: AppStrings.registerScreenGenderLabel.tr(),
                isObscured: false,
                readOnly: true,
                hint: AppStrings.registerScreenGenderHint.tr(),
                validation: AppValidators.validateGender,
                textInputType: TextInputType.number,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      viewModel.getGenderController.text = v;
                    },
                    title: AppStrings.registerScreenGenderLabel.tr(),
                    items: genderList,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getJobController,
                focusNode: jobFocusNode,
                nextFocus: salaryFocusNode,
                label: AppStrings.registerScreenJobLabel.tr(),
                isObscured: false,
                validation: AppValidators.validateJob,
                hint: AppStrings.registerScreenJobHint.tr(),
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getSalaryController,
                focusNode: salaryFocusNode,
                nextFocus: ageFocusNode,
                label: AppStrings.registerScreenSalaryLabel.tr(),
                isObscured: false,
                validation: AppValidators.validateSalary,
                hint: AppStrings.registerScreenSalaryHint.tr(),
                textInputType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getAgeController,
                focusNode: ageFocusNode,
                nextFocus: martialStatusFocusNode,
                label: AppStrings.registerScreenAgeLabel.tr(),
                isObscured: false,
                validation: AppValidators.validateAge,
                hint: AppStrings.registerScreenAgeHint.tr(),
                textInputType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getMartialStatusController,
                focusNode: martialStatusFocusNode,
                label: AppStrings.registerScreenMartialStatusLabel.tr(),
                isObscured: false,
                readOnly: true,
                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.registerScreenMartialStatusHint.tr(),
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      viewModel.getMartialStatusController.text = v;
                    },
                    title: AppStrings.registerScreenMartialStatusLabel.tr(),
                    items: martialStatusList,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p30),
              child: MainButton(
                text: AppStrings.registerScreenButton.tr(),
                textStyle: AppTextStyles.authButtonTextStyle(context),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.register();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SocialContainer(
                title: AppStrings.registerScreenFacebook.tr(),
                image: SVGAssets.facebook,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SocialContainer(
                title: AppStrings.registerScreenGoogle.tr(),
                image: SVGAssets.gmail,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
