import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/payment_details/view/widgets/payment_details_body.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';


import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../login_screen/viewmodel/login_viewmodel.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';
import '../../share_post_screen/view/widgets/share_text_field.dart';
import '../viewmodel/payment_view_model.dart';

class PaymentScreenDetails extends StatelessWidget {
  const PaymentScreenDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.paymentDetailsScreenTitle.tr(),
          style: AppTextStyles.paymentAppBarTextStyle(),
        ),
      ),
      body:  BlocProvider(
        create: (_) => PaymentViewModel()..start(),
        child: BlocConsumer<PaymentViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, PaymentDetailsBody(viewModel: PaymentViewModel(),));

          },
        ),
      ),
    );
  }
}
