import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/presentation/homes_map_screen/viewmodel/homes_map_viewmodel.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class HomesMapBody extends StatelessWidget {
  const HomesMapBody({super.key});

  static late HomesMapViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = HomesMapViewModel.get(context);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        height: AppSize.infinity,
        width: AppSize.infinity,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _viewModel.getInitialLocation ?? _viewModel.getUserLocation,
            zoom: AppSize.s16,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) {
            _viewModel.setMapController = controller;
          },
          zoomControlsEnabled: false,
          markers: _viewModel.getHomesMarkers,
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _viewModel.goToMyLocation,
        backgroundColor: ColorManager.white,
        child: SvgPicture.asset(SVGAssets.location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
