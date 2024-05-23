import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_builder.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/splash_screen/states/splash_states.dart';
import 'package:temp_house/presentation/splash_screen/viewmodel/splash_viewmodel.dart';

import 'widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = 'splashscreen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashViewModel()..start(),
        child: BlocConsumer<SplashViewModel, BaseStates>(
          listener: (context, state) {
            if (state is UserSignedState) {
              Navigator.pushReplacementNamed(context, Routes.mainLayoutRoute);
            } else if (state is UserNotSignedState) {
              Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, const SplashScreenBody());
          },
        ),
      ),
    );
  }
}
