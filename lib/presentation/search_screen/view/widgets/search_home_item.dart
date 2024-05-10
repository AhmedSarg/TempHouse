import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../common/widget/cached_image.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SearchHomeItem extends StatefulWidget {
  const SearchHomeItem({
    super.key,
    required this.color,
    required this.title,
    required this.id,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.numnerofBeds,
    required this.wifiServices,
    required this.numnerofbathroom,
    required this.date,
    required this.description,
    required this.coardinaties,
    required this.rating,
    required this.numberOfRatings,
  });
  final Color color;
  final String title;
  final String id;
  final num price;
  final num rating;
  final num numberOfRatings;
  final String location;
  final String imageUrl;
  final String numnerofBeds;
  final String wifiServices;
  final String numnerofbathroom;
  final String date;
  final String description;
  final GeoPoint coardinaties;

  @override
  State<SearchHomeItem> createState() => _NearByHomeItemState();
}

class _NearByHomeItemState extends State<SearchHomeItem> {
  bool isFav = false;
  bool isFavMessage = false;

  @override
  Widget build(BuildContext context) {
    final double displayedRating = (widget.rating / widget.numberOfRatings).clamp(0, 5);

    return Container(
      margin: const EdgeInsets.all(AppMargin.m10),
      color: ColorManager.primary,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: CachedImage(
                  imageUrl: widget.imageUrl ?? "",
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: AppSize.s120,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s10),
            SizedBox(
              width: context.width() - AppSize.s180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.title,
                          style: AppTextStyles.homegenertalTextStyle(
                              context, ColorManager.offwhite, FontSize.f18),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            var snackBar = SnackBar(
                              backgroundColor: ColorManager.offwhite,
                              closeIconColor: ColorManager.primary,
                              showCloseIcon: true,
                              duration: const Duration(seconds: AppDuration.s3),
                              content: Text(
                                isFavMessage
                                    ? AppStrings.removeItem.tr()
                                    : AppStrings.addItem.tr(),
                                style: AppTextStyles.nearHomeAddressTextStyle(
                                    context),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            setState(() {
                              isFav = !isFav;
                              isFavMessage = !isFavMessage;
                            });
                          },
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_outline,
                            color: ColorManager.grey,
                            size: AppSize.s28,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        SVGAssets.pin,
                        color: ColorManager.grey,
                        width: AppSize.s20,
                      ),
                      Expanded(
                        child: Text(
                          widget.location,
                          maxLines: 1,
                          style: AppTextStyles.homegenertalTextStyle(
                              context, ColorManager.offwhite, FontSize.f14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  Row(
                    children: [
                      const SizedBox(width: AppSize.s10),
                      Text(
                        '${AppStrings.coin.tr()} ${widget.price}${widget.date}',
                        style: AppTextStyles.homegenertalTextStyle(
                            context, ColorManager.offwhite, FontSize.f14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: AppSize.s20,
                      ),
                      Text(
                        displayedRating.toStringAsFixed(1),
                        style: AppTextStyles.homegenertalTextStyle(
                            context, ColorManager.offwhite, FontSize.f12),
                      ),
                      const SizedBox(width: AppSize.s5),
                      Text(
                        '(${widget.numberOfRatings})',
                        style: AppTextStyles.homegenertalTextStyle(
                            context,
                            ColorManager.tertiary.withOpacity(.7),
                            FontSize.f12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
