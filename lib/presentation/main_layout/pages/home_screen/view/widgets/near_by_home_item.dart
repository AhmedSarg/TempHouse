import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../common/widget/cached_image.dart';
import '../../../../../common/widget/main-divider.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';

class NearByHomeItem extends StatefulWidget {
  const NearByHomeItem({
    Key? key,
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
    required this.coardinaties, required this.rating, required this.numberOfRatings,
  }) : super(key: key);

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
  State<NearByHomeItem> createState() => _NearByHomeItemState();
}

class _NearByHomeItemState extends State<NearByHomeItem> {
  bool isFav = false;
  bool isFavMessage = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  void checkIfFavorite() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(DataIntent.getUser().uid)
        .collection('items')
        .doc(widget.id)
        .get();

    if (mounted) {
      setState(() {
        isFav = docSnapshot.exists;
      });
    }
  }

  void addToFavorites() async {
    await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(DataIntent.getUser().uid)
        .collection('items')
        .doc(widget.id)
        .set({
      'price': widget.price,
      'title': widget.title,
      'homeId': widget.id,
      'userId': DataIntent.getUser().uid,
      'location': widget.location,
      'imageUrl': widget.imageUrl,
      'numnerofBeds': widget.numnerofBeds,
      'wifiServices': widget.wifiServices,
      'numnerofbathroom': widget.numnerofbathroom,
      'date': widget.date,
      'description': widget.description,
      'coardinaties': widget.coardinaties,
    }, SetOptions(merge: true));

    setState(() {
      isFav = true;
    });
  }

  void removeFromFavorites(String userId, String homeId) async {
    if (!mounted) return;

    await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(userId)
        .collection('items')
        .doc(homeId)
        .delete();

    if (mounted) {
      setState(() {
        isFav = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double displayedRating = (widget.rating / widget.numberOfRatings).clamp(0, 5);
    return Container(
      margin: const EdgeInsets.all(AppMargin.m10),
      color: ColorManager.transparent,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
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
                          style: AppTextStyles.nearHomeNameTextStyle(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (!isFav) {
                              addToFavorites();
                            } else {
                              removeFromFavorites(DataIntent.getUser().uid, widget.id);
                            }
                            isFav = !isFav;
                          });
                        },                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_outline,
                          color: isFav ? Colors.red : null,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        SVGAssets.pin,
                        color: ColorManager.primary,
                        width: AppSize.s20,
                      ),
                      Expanded(
                        child: Text(
                          widget.location,
                          maxLines: 1,
                          style:
                          AppTextStyles.nearHomeAddressTextStyle(context),
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
                        style: AppTextStyles.nearHomeAddressTextStyle(context),
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
                        style: AppTextStyles.homeItemRateTextStyle(context),
                      ),
                      const SizedBox(width: AppSize.s5),
                      Text(
                        '(${widget.numberOfRatings})',
                        style: AppTextStyles.homeItemSecondTextStyle(context),
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
