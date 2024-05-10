import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

class MainCicleProcessIndicator extends StatelessWidget {
  const MainCicleProcessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: ColorManager.offwhite,));
  }
}
