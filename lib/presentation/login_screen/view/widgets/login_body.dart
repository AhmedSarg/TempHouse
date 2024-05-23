import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/social_container.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/login_viewmodel.dart';
import 'forgot_password.dart';

class LoginBody extends StatelessWidget {
  LoginBody({
    super.key,
    required this.viewModel,
  });

  final LoginViewModel viewModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppSize.s50,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MainTextField(
                maxLines: 1,
                controller: viewModel.getEmailController,
                focusNode: emailFocusNode,
                nextFocus: passwordFocusNode,
                validation: AppValidators.validateLogin,
                label: AppStrings.loginScreenEmailLabel.tr(),
                isObscured: false,
                hint: AppStrings.loginScreenEmailHint.tr(),
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSize.s20),
              MainTextField(
                maxLines: 1,
                controller: viewModel.getPasswordController,
                focusNode: passwordFocusNode,
                validation: AppValidators.validateLogin,
                label: AppStrings.loginScreenPasswordLabel.tr(),
                isObscured: true,
                hint: AppStrings.loginScreenPasswordHint.tr(),
                iconData: Icons.remove_red_eye_outlined,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: AppSize.s20),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      viewModel.getForgotPasswordEmailController.text =
                          viewModel.getEmailController.text;
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Form(
                            key: _resetFormKey,
                            child: ForgotPassword(
                              viewModel: viewModel,
                              formKey: _resetFormKey,
                              emailFocusNode: FocusNode(),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      AppStrings.loginScreenForgotPassword.tr(),
                      style: AppTextStyles.authActionsTextStyle(context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerRoute);
                    },
                    child: Text(
                      AppStrings.loginScreenCreateAccount.tr(),
                      style: AppTextStyles.authActionsTextStyle(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s50),
              Center(
                child: MainButton(
                  text: AppStrings.loginScreenButton.tr(),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.login();
                    }
                  },
                  textStyle: AppTextStyles.authButtonTextStyle(context),
                ),
              ),
              const SizedBox(height: AppSize.s50),
              Center(
                child: Column(
                  children: [
                    SocialContainer(
                      title: AppStrings.loginScreenFacebook.tr(),
                      image: SVGAssets.facebook,
                    ),
                    const SizedBox(height: AppSize.s10),
                    SocialContainer(
                      title: AppStrings.loginScreenGoogle.tr(),
                      image: SVGAssets.gmail,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
