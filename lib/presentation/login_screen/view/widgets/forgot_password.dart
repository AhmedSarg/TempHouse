import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/login_screen/viewmodel/login_viewmodel.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import 'reset_password.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.viewModel,
    required this.formKey,
    required this.emailFocusNode,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode emailFocusNode;
  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.p16,
        right: AppPadding.p16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .45,
        width: AppSize.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              AppStrings.forgotPasswordTitle.tr(),
              style: AppTextStyles.forgotPasswordTitleTextStyle(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: MainTextField(
                controller: viewModel.getForgotPasswordEmailController,
                focusNode: emailFocusNode,
                textInputType: TextInputType.emailAddress,
                validation: AppValidators.validateEmail,
                hint: AppStrings.forgotPasswordEmailValue.tr(),
                backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                hintTextStyle:
                    AppTextStyles.forgotPasswordEmailValueTextStyle(context),
                cursorColor: ColorManager.primary.withOpacity(.3),
              ),
            ),
            const Spacer(),
            const Divider(height: AppSize.s0),
            const Spacer(),
            MainButton(
              text: AppStrings.forgotPasswordSendCode.tr(),
              onTap: () {
                print(emailFocusNode.hasFocus);
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => Form(
                      key: formKey,
                      child: ResetPassword(
                        viewModel: viewModel,
                        formKey: formKey,
                        passwordFocusNode: FocusNode(),
                        confirmPasswordFocusNode: FocusNode(),
                      ),
                    ),
                  );
                }
              },
              textStyle: AppTextStyles.forgotPasswordSendCodeTextStyle(context),
              backgroundColor: ColorManager.grey,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
