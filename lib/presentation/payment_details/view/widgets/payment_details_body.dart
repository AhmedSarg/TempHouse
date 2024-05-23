import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../../share_post_screen/view/widgets/share_text_field.dart';
import '../../viewmodel/payment_viewmodel.dart';

class PaymentDetailsBody extends StatelessWidget {
  PaymentDetailsBody({Key? key, required this.viewModel}) : super(key: key);
  final PaymentViewModel viewModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode cardholderFocusNode = FocusNode();
  final FocusNode cardNumberFocusNode = FocusNode();
  final FocusNode expirationFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppPadding.p8,
                  ),
                  child: Text(
                    AppStrings.paymentCardholder.tr(),
                    style: AppTextStyles.profileInfoSubTitle(context),
                  ),
                ),
                SearchTextField(
                  textInputType: TextInputType.name,
                  controller: viewModel.getCardNameController,
                  focusNode: cardholderFocusNode,
                  cursorColor: ColorManager.white,
                  validation: (v) {
                    if (v == null || v.isEmpty) {
                      return AppStrings.validationsFieldRequired.tr();
                    } else {
                      return null;
                    }
                  },
                  hint: '',
                  nextFocus: cardNumberFocusNode,
                ),
                const SizedBox(height: AppSize.s20),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppPadding.p8,
                  ),
                  child: Text(
                    AppStrings.paymentCardNumber.tr(),
                    style: AppTextStyles.profileInfoSubTitle(context),
                  ),
                ),
                SearchTextField(
                  textInputType: TextInputType.phone,
                  controller: viewModel.getCardNumberController,
                  focusNode: cardNumberFocusNode,
                  validation: (v) {
                    if (v == null || v.isEmpty) {
                      return AppStrings.validationsFieldRequired.tr();
                    } else if (v.length != 16) {
                      return AppStrings.validationsNumbersMustEqual16Digit.tr();
                    } else {
                      return null;
                    }
                  },
                  cursorColor: ColorManager.white,
                  hint: '',
                  prefixIcon: Icons.credit_card_rounded,
                  nextFocus: expirationFocusNode,
                ),
                const SizedBox(height: AppSize.s20),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppPadding.p8,
                  ),
                  child: Text(
                    AppStrings.paymentExpiration.tr(),
                    style: AppTextStyles.profileInfoSubTitle(context),
                  ),
                ),
                SearchTextField(
                  controller: viewModel.getCardExpirationDateController,
                  focusNode: expirationFocusNode,
                  cursorColor: ColorManager.white,
                  hint: 'MM / YY',
                  validation: (v) {
                    if (v == null || v.isEmpty) {
                      return AppStrings.validationsFieldRequired.tr();
                    } else if (v.length != 4) {
                      return AppStrings.validationsNumbersMustEqual11Digit.tr();
                    } else if (int.parse(v.substring(0, 2)) > 31 ||
                        int.parse(v.substring(0, 2)) < 1 ||
                        int.parse(v.substring(2, 4)) <
                            int.parse(DateTime.now()
                                .year
                                .toString()
                                .substring(2, 4))) {
                      return AppStrings.validationsInvalidCardExpirationDate
                          .tr();
                    } else {
                      return null;
                    }
                  },
                  textInputType: TextInputType.phone,
                  nextFocus: expirationFocusNode,
                ),
              ],
            ),
            const SizedBox(height: AppSize.s40),
            Center(
              child: MainButton(
                backgroundColor: ColorManager.white,
                text: AppStrings.paymentSaveCardButton.tr(),
                textStyle: AppTextStyles.personalInfoBtn(context),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.addCard();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
