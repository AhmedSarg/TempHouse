import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class ResetSuccess extends StatelessWidget {
  const ResetSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.infinity,
      width: AppSize.infinity,
      
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: ColorManager.secondary,
            borderRadius: BorderRadius.circular(AppSize.s100),
            child: Lottie.asset(
              LottieAssets.success,
              width: AppSize.s200,
              height: AppSize.s200,
              repeat: false,
            ),
          ),
        ),
      ),
    );
  }
}
