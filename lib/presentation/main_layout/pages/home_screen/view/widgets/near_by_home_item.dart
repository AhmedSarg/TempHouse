import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../common/widget/cached_image.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';

class NearByHomeItem extends StatelessWidget {
  const NearByHomeItem({
    super.key,
    required this.home,
  });

  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    final double displayedRating = (home.rate / home.numberOfRates).clamp(0, 5);
    return BlocBuilder<MainLayoutViewModel, BaseStates>(
      builder: (context, state) {
        MainLayoutViewModel viewModel = MainLayoutViewModel.get(context);
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
                      imageUrl: home.imageUrl,
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
                              home.title,
                              style:
                                  AppTextStyles.nearHomeNameTextStyle(context),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (viewModel.getUser
                                  .isHomeInFavorites(home.homeId)) {
                                viewModel.removeFromFavorites(home.homeId);
                              } else {
                                viewModel.addToFavorites(home.homeId);
                              }
                            },
                            icon: viewModel.getUser
                                    .isHomeInFavorites(home.homeId)
                                ? SvgPicture.asset(SVGAssets.favouraiteFill)
                                : SvgPicture.asset(SVGAssets.favouraiteLight),
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
                              home.location,
                              maxLines: 1,
                              style: AppTextStyles.nearHomeAddressTextStyle(
                                  context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s5),
                      Row(
                        children: [
                          const SizedBox(width: AppSize.s10),
                          Expanded(
                            child: Text(
                              '${AppStrings.coin.tr()} ${home.price}/${home.rentPeriod}',
                              style: AppTextStyles.nearHomeAddressTextStyle(
                                  context),
                              overflow: TextOverflow.ellipsis,
                            ),
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
                            '(${home.numberOfRates})',
                            style:
                                AppTextStyles.homeItemSecondTextStyle(context),
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
      },
    );
  }
}

// void checkIfFavorite() async {
//   final docSnapshot = await FirebaseFirestore.instance
//       .collection('Favorites')
//       .doc(DataIntent.getUser().uid)
//       .collection('items')
//       .doc(widget.id)
//       .get();
//
//   if (mounted) {
//     setState(() {
//       isFav = docSnapshot.exists;
//     });
//   }
// }
//
// void removeFromFavorites(String userId, String homeId) async {
//   if (!mounted) return;
//
//   await FirebaseFirestore.instance
//       .collection('Favorites')
//       .doc(userId)
//       .collection('items')
//       .doc(homeId)
//       .delete();
//
//   if (mounted) {
//     setState(() {
//       isFav = false;
//     });
//   }
// }
