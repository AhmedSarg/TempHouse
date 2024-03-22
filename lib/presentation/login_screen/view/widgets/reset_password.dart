import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/login_viewmodel.dart';
import 'reset_success.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    super.key,
    required this.viewModel,
    required this.formKey,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
  });

  final LoginViewModel viewModel;

  final GlobalKey<FormState> formKey;

  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .7,
        width: AppSize.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              AppStrings.resetPasswordTitle.tr(),
              style: AppTextStyles.resetPasswordTitleTextStyle(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: MainTextField(
                controller: viewModel.getForgotPasswordEmailController,
                focusNode: FocusNode(),
                nextFocus: passwordFocusNode,
                label: null,
                readOnly: true,
                hint: AppStrings.resetPasswordEmailValue.tr(),
                backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                hintTextStyle:
                    AppTextStyles.resetPasswordEmailValueTextStyle(context),
              ),
            ),
            const Spacer(),
            const Divider(height: AppSize.s0),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: MainTextField(
                controller: viewModel.getResetPasswordController,
                focusNode: passwordFocusNode,
                nextFocus: confirmPasswordFocusNode,
                isObscured: true,
                label: AppStrings.resetPasswordPasswordLabel.tr(),
                hint: AppStrings.resetPasswordPasswordHint.tr(),
                validation: AppValidators.validatePassword,
                backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                hintTextStyle: AppTextStyles.resetPasswordPasswordHintTextStyle(context),
                cursorColor: ColorManager.primary,
                labelTextStyle: AppTextStyles.resetPasswordPasswordLabelTextStyle(context),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: MainTextField(
                controller: viewModel.getResetPasswordConfirmController,
                focusNode: confirmPasswordFocusNode,
                isObscured: true,
                label: AppStrings.resetPasswordConfirmLabel.tr(),
                hint: AppStrings.resetPasswordPasswordHint.tr(),
                validation: (v) {
                  return AppValidators.validateConfirmPassword(v, 'Pass1234');
                },
                backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                hintTextStyle:
                    AppTextStyles.resetPasswordPasswordHintTextStyle(context),
                cursorColor: ColorManager.primary,
                labelTextStyle:
                    AppTextStyles.resetPasswordPasswordLabelTextStyle(context),
              ),
            ),
            const Spacer(),
            MainButton(
              text: AppStrings.resetPasswordChange.tr(),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const ResetSuccess(),
                  );
                }
              },
              textStyle: AppTextStyles.resetPasswordChangeTextStyle(context),
              backgroundColor: ColorManager.grey,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
