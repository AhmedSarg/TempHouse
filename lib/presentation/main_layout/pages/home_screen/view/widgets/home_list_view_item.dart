import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import 'home_image.dart';

class BuildCarouselItem extends StatelessWidget {
  const BuildCarouselItem({
    super.key,
    required this.home,
  });

  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    final double displayedRating = (home.rate / home.numberOfRates).clamp(0, 5);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.offwhite,
          borderRadius: BorderRadius.circular(AppPadding.p16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 0.2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
            vertical: AppPadding.p12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s150,
                child: HomeImageWidget(
                  home: home,
                ),
              ),
              const SizedBox(height: AppPadding.p5),
              FittedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      displayedRating.toStringAsFixed(1),
                      style: AppTextStyles.homeItemRateTextStyle(context),
                    ),
                    Text(
                      ' (${home.numberOfRates})',
                      style: AppTextStyles.homeItemSecondTextStyle(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  home.title,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyles.homeNameTextStyle(context),
                ),
              ),
              const SizedBox(height: AppPadding.p5),
              Row(
                children: [
                  SvgPicture.asset(
                    SVGAssets.pin,
                    color: ColorManager.primary,
                  ),
                  Expanded(
                    child: Text(
                      home.location,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.homeAddressTextStyle(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppPadding.p10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          SVGAssets.bed,
                          colorFilter: const ColorFilter.mode(
                            ColorManager.primary,
                            BlendMode.dstIn,
                          ),
                        ),
                        Text(
                          ' ${home.numberOfBeds} ',
                          style: AppTextStyles.homeContentTextStyle(context),
                        ),
                        Text(
                          '${AppStrings.bedHome.tr()} ',
                          style: AppTextStyles.homeContentTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          SVGAssets.wifi,
                          colorFilter: const ColorFilter.mode(
                            ColorManager.primary,
                            BlendMode.dstIn,
                          ),
                        ),
                        Text(
                          ' ${home.wifiServices ? AppStrings.wifiServicesYes.tr() : AppStrings.wifiServicesNo.tr()} ',
                          style: AppTextStyles.homeContentTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            SVGAssets.bathRoom,
                            colorFilter: const ColorFilter.mode(
                              ColorManager.primary,
                              BlendMode.dstIn,
                            ),
                          ),
                          Text(
                            ' ${home.numberOfBathrooms} ',
                            style: AppTextStyles.homeContentTextStyle(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.bathroomHome.tr(),
                              style:
                                  AppTextStyles.homeContentTextStyle(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.object,
    required this.icon,
    this.number,
    this.color,
  });

  final String object;
  final dynamic icon;
  final int? number;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (icon is String)
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
                color ?? ColorManager.primary, BlendMode.dstIn),
          )
        else if (icon is IconData)
          Icon(
            icon,
            color: ColorManager.primary,
          ),
        Text(
          number?.toString() ?? '',
          style: AppTextStyles.homeContentTextStyle(context),
        ),
        Text(
          object,
          style: AppTextStyles.homeContentTextStyle(context),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
