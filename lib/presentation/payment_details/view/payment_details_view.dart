import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/payment_details/view/widgets/payment_details_body.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../viewmodel/payment_viewmodel.dart';

class PaymentScreenDetails extends StatelessWidget {
  const PaymentScreenDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.paymentDetailsScreenTitle.tr(),
          style: AppTextStyles.paymentAppBarTextStyle(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => PaymentViewModel()..start(),
        child: BlocConsumer<PaymentViewModel, BaseStates>(
          listener: (context, state) {
            if (state is ErrorState || state is SuccessState) {
              Navigator.pop(context);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              PaymentDetailsBody(
                viewModel: PaymentViewModel.get(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
