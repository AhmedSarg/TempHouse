import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/common/widget/cached_image.dart';

import '../../../../../../domain/models/enums.dart';
import '../../../../../common/data_intent/data_intent.dart';
import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import 'feed_back.dart';

class HomeImageWidget extends StatefulWidget {
  const HomeImageWidget({
    super.key,
    required this.price,
    required this.imageUrl,
    required this.date, required this.id,
  });

  final String price;
  final String id;
  final String imageUrl;
  final String date;

  @override
  State<HomeImageWidget> createState() => _HomeImageWidgetState();
}

class _HomeImageWidgetState extends State<HomeImageWidget> {
  bool isFavourite = false;
  bool isFavMessage = false;

  UserRole? userRole = DataIntent.getUserRole();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedImage(
              imageUrl: widget.imageUrl,
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
                        '${widget.price} ${AppStrings.priceHome.tr()}${widget.date} ',
                        style: AppTextStyles.homeItemPriceTextStyle(context)),
                  )),
               const Spacer(),
              InkWell(
                onTap: () {
                  var snackBar = SnackBar(
                    backgroundColor: ColorManager.offwhite,
                    closeIconColor: ColorManager.primary,
                    showCloseIcon: true,
                    duration: const Duration(seconds: AppDuration.s3),
                    content: Text(
                      isFavMessage
                          ? AppStrings.removeItem.tr()
                          : AppStrings.addItem.tr(),
                      style: AppTextStyles.nearHomeAddressTextStyle(context),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    isFavourite = !isFavourite;
                    isFavMessage = !isFavMessage;
                  });
                },
                child: userRole == UserRole.owner
                    ? Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        color: isFavourite
                            ? ColorManager.primary
                            : ColorManager.white,
                        size: 30,
                      )
                    : Container(
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
                                text:
                                    AppStrings.optionsMenuAddAddToFavorite.tr(),
                                icon: isFavourite
                                    ? SvgPicture.asset(SVGAssets.favouraiteFill)
                                    : SvgPicture.asset(
                                        SVGAssets.favouraiteLight),
                                onPressed: () {
                                  setState(() {
                                    isFavourite = !isFavourite;
                                  });
                                },
                              ),
                              OptionMenuItem(
                                text: AppStrings.optionsMenuFeedback.tr(),
                                icon: SvgPicture.asset(SVGAssets.feedBack),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RatingDialog(homeItemId: widget.id);
                                    },
                                  );
                                },
                              ),
                            ],
                            mainIcon: Icons.menu,
                          ),
                        ),
                      ),
              )
            ],
          ),
        )
      ],
    );
  }
}
