import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';

class MainSearch extends StatelessWidget {
  const MainSearch({
    super.key,
    required this.hintText,
    required this.leadingIcon,
    required this.trailingIcon,
    this.controller,
    this.onSubmit,
    this.onChanged,
  });

  final String hintText;
  final IconData leadingIcon;
  final Widget trailingIcon;
  final TextEditingController? controller;
  final Function? onSubmit;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.offwhite.withOpacity(.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            cursorColor: ColorManager.white,
            onChanged: onChanged,
            onSubmitted: (value) {
              if (onSubmit != null) {
                onSubmit!(value);
              }
            },
            style: AppTextStyles.searchTextStyle(context),
            decoration: InputDecoration(
              prefixIcon: Icon(leadingIcon),
              prefixIconColor: ColorManager.offwhite.withOpacity(.86),
              hintText: hintText,
              hintStyle: AppTextStyles.searchHintTextStyle(context),
              border: InputBorder.none,
              fillColor: Colors.transparent,
              filled: false,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (await checkPermission(context)) {
              Navigator.pushNamed(context, Routes.homesMapRoute);
            } else {
              await requestPermission(context);
              if (await checkPermission(context)) {
                Navigator.pushNamed(context, Routes.homesMapRoute);
              } else {
                if (await Geolocator.isLocationServiceEnabled()) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(LottieAssets.error, repeat: false),
                          const Text(
                            'Please enable Location Services and Location Permissions',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await Geolocator.openAppSettings();
                          },
                          child: const Text('Open Settings'),
                        )
                      ],
                    ),
                  );
                }
              }
            }
          },
          icon: trailingIcon,
        ),
      ],
    );
  }

  Future<bool> checkPermission(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Lottie.asset(LottieAssets.loading),
      ),
    );
    LocationPermission locationPermission = await Geolocator.checkPermission();
    bool locationServices = await Geolocator.isLocationServiceEnabled();
    print(locationPermission);
    print(locationServices);
    if (locationPermission == LocationPermission.deniedForever ||
        locationPermission == LocationPermission.denied ||
        !locationServices) {
      Navigator.pop(context);
      return false;
    } else {
      Navigator.pop(context);
      return true;
    }
  }

  requestPermission(BuildContext context) async {
    bool services = await Geolocator.isLocationServiceEnabled();
    if (!services) {
      await Geolocator.openLocationSettings();
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    } else if (locationPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }
}
