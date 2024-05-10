import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

class MainDivider extends StatelessWidget {
  const MainDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorManager.primary,
      height: 3,
    );
  }
}
