import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/widget/cached_image.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';

import '../../../../../../domain/models/enums.dart';
import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import 'feed_back.dart';

class HomeImageWidget extends StatelessWidget {
  const HomeImageWidget({
    super.key,
    required this.home,
  });

  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutViewModel, BaseStates>(
      builder: (context, state) {
        MainLayoutViewModel viewModel = MainLayoutViewModel.get(context);
        return Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedImage(
                  imageUrl: home.imageUrl,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p5, horizontal: AppPadding.p5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorManager.black.withOpacity(.55),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Text(
                          '${home.price} ${AppStrings.priceHome.tr()}${home.rentPeriod} ',
                          style: AppTextStyles.homeItemPriceTextStyle(context)),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: AppSize.s34,
                    height: AppSize.s34,
                    decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(.55),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: OptionMenu(
                        items: [
                          OptionMenuItem(
                            text: AppStrings.optionsMenuAddAddToFavorite.tr(),
                            icon: viewModel.isHomeFavorite(home.homeId)
                                ? SvgPicture.asset(SVGAssets.favouraiteFill)
                                : SvgPicture.asset(SVGAssets.favouraiteLight),
                            onPressed: () {
                              if (viewModel.isHomeFavorite(home.homeId)) {
                                viewModel.removeFromFavorites(home.homeId);
                              } else {
                                viewModel.addToFavorites(home.homeId);
                              }
                            },
                          ),
                          viewModel.getUserRole == UserRole.tenant
                              ? OptionMenuItem(
                                  text: AppStrings.optionsMenuFeedback.tr(),
                                  icon: SvgPicture.asset(SVGAssets.feedBack),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RatingDialog(
                                          homeItemId: home.homeId,
                                        );
                                      },
                                    );
                                  },
                                )
                              : null,
                        ],
                        mainIcon: Icons.menu,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
