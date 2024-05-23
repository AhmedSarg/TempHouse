import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_builder.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/main_layout/view/main_layout_body.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MainLayoutViewModel()..start(),
        child: BlocConsumer<MainLayoutViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, const MainLayoutBody());
          },
        ),
      ),
    );
  }
}
