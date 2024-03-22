import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'widgets/splash_body.dart';


class SplashScreen extends StatelessWidget {
  static String routeName ='splashscreen';

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
}