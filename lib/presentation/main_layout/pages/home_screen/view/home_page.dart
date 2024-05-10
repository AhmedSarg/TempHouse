import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../../../../domain/models/enums.dart';
import '../../../../common/data_intent/data_intent.dart';
import 'widgets/home_page_body.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  UserRole? userRole = DataIntent.getUserRole();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: userRole == UserRole.owner
          ?  FloatingActionButton(
        backgroundColor: ColorManager.primary,
        shape: const OvalBorder(),
        onPressed: () {
          Navigator.pushNamed(context, Routes.publishHomePostRoute);
        },
        child: const Icon(
          Icons.add,
          color: ColorManager.white,
          size: 28,
        ),
      )
          : null,
      body: const HomePageBody(),
    );
  }
}
