import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/share_post_screen/view/widgets/share_screen_body.dart';
import 'package:temp_house/presentation/share_post_screen/viewmodel/share_view_model.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

class SharePostScreen extends StatelessWidget {
  const SharePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.publishHomeAppBarTextRow.tr(),
          style: AppTextStyles.loginTitleTextStyle(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => ShareViewModel(sl())..start(),
        child: BlocConsumer<ShareViewModel, BaseStates>(
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainLayoutRoute,
                ModalRoute.withName('/'),
              );
            } else if (state is ErrorState) {
              Navigator.pop(context);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              SharePostScreenBody(
                viewModel: ShareViewModel.get(context),
                formKey: GlobalKey<FormState>(),
                titleFocusNode: FocusNode(),
                descriptionFocusNode: FocusNode(),
                bathroomFocusNode: FocusNode(),
                bedFocusNode: FocusNode(),
                categoryFocusNode: FocusNode(),
                locationFocusNode: FocusNode(),
                priceFocusNode: FocusNode(),
                wifiFocusNode: FocusNode(),
                conditionFocusNode: FocusNode(), areaFocusNode: FocusNode(),
              ),
            );
          },
        ),
      ),
    );
  }
}
