import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);

  final String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const Center(child: Icon(Icons.error_outline,color: ColorManager.error,size: AppSize.s40,),); // Placeholder widget or error message
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: ColorManager.white,
          strokeWidth: AppSize.s1,
          strokeCap: StrokeCap.round,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red),
    );
  }
}
