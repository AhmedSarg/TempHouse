import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/register_screen/view/widgets/register_owner_body.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../viewmodel/register_viewmodel.dart';
import 'widgets/register_tenant_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.registerScreenTitle.tr(),
          style: AppTextStyles.registerTitleTextStyle(context),
        ),
      ),
      body: BlocProvider(
        create: (_) => RegisterViewModel(sl())..start(),
        child: BlocConsumer<RegisterViewModel, BaseStates>(
          listener: (context, state) {
            if (state is ErrorState) {
              Navigator.pop(context);
            } else if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainLayoutRoute,
                ModalRoute.withName('/'),
              );
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            RegisterViewModel viewModel = RegisterViewModel.get(context);
            return baseBuilder(
              context,
              state,
              viewModel.getRegisterType == UserRole.owner
                  ? RegisterOwnerBody(viewModel: viewModel)
                  : RegisterTenantBody(viewModel: viewModel),
            );
          },
        ),
      ),
    );
  }
}
