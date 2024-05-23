import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../../../../domain/models/enums.dart';
import 'widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static late MainLayoutViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = MainLayoutViewModel.get(context);
    return Scaffold(
      floatingActionButton: _viewModel.getUserRole == UserRole.owner
          ? FloatingActionButton(
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
