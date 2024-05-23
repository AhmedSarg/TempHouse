import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_builder.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/pages/view/personal_info_page_body.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/pages/viewmodel/personal_info_viewmodel.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalInfoViewModel()..start(),
      child: BlocConsumer<PersonalInfoViewModel, BaseStates>(
        listener: (context, state) {
          if (state is SuccessState || state is ErrorState) {
            Navigator.pop(context);
          }
          baseListener(context, state);
        },
        builder: (context, state) {
          return baseBuilder(context, state, PersonalInfoPageBody());
        },
      ),
    );
  }
}
