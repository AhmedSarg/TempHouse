import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../../share_post_screen/view/widgets/share_text_field.dart';
import '../../viewmodel/payment_view_model.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p8),
                  child: Text(
                    AppStrings.paymentCardholder.tr(),
                    style: AppTextStyles.profileInfoSubTitle(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p8),
                  child: SearchTextField(
                    textInputType: TextInputType.name,
                    controller: viewModel.getCardholderController,
                    focusNode: cardholderFocusNode,
                    hint: '',
                    nextFocus: cardNumberFocusNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p8),
                  child: Text(
                    AppStrings.paymentCardNumber.tr(),
                    style: AppTextStyles.profileInfoSubTitle(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p8),
                  child: SearchTextField(
                    textInputType: TextInputType.phone,
                    controller: viewModel.getCardNamberController,
                    focusNode: cardNumberFocusNode,
                    hint: '',
                    prefixIcon: Icons.credit_card_rounded,
                    nextFocus: expirationFocusNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p8),
                  child: Text(
                    AppStrings.paymentExpiration.tr(),
                    style: AppTextStyles.profileInfoSubTitle(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p8),
                  child: SearchTextField(
                    controller: viewModel.getExpirationController,
                    focusNode: expirationFocusNode,
                    hint: 'MM / YY',
                    textInputType: TextInputType.phone,
                    nextFocus: expirationFocusNode,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s40,
            ),

            Center(
              child: MainButton(
                backgroundColor: ColorManager.white,
                text: 'Save Card ',
                textStyle: AppTextStyles.personalInfoBtn(context),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO
                  }
        
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            )
          ],
        ),
      ),
    );
  }
}
