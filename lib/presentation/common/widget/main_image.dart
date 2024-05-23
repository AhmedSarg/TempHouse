import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class MainImage extends StatelessWidget {
  const MainImage({
    super.key,
    required this.imageUrl,
    this.width = AppSize.s100,
  });

  final String imageUrl;
  final double width;

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Container(
      width: width,
      height: width,
      decoration: const BoxDecoration(
        color: ColorManager.white,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: imageUrl.contains('http')
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: Lottie.asset(
                    LottieAssets.loading,
                    width: width * .8,
                  ),
                );
              },
            )
          : imageUrl.contains('cache')
              ? Image.memory(
                  File(imageUrl).readAsBytesSync(),
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
    );
  }
}
