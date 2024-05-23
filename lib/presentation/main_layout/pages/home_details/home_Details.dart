import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chat_screen/view/chat_view.dart';
import 'package:temp_house/presentation/common/widget/cached_image.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../common/data_intent/data_intent.dart';
import '../../../common/widget/main_app_bar.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';

class HomeDetailsScreen extends StatefulWidget {
  final HomeModel home;

  const HomeDetailsScreen({
    super.key,
    required this.home,
  });

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int _currentIndex = 0;
  ChatServices chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    final int displayedRating =
        (widget.home.rate / widget.home.numberOfRates).clamp(0, 5).floor();

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: AppSize.s80,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: AppSize.s50,
                margin: const EdgeInsets.symmetric(
                    horizontal: AppMargin.m10, vertical: AppMargin.m8),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                    ColorManager.blue.withOpacity(.7),
                  )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          receiveEmail: widget.home.ownerName,
                          receiveID: widget.home.ownerId,
                          chatID: chatServices.getChatRoomID(
                            DataIntent.getUser().uid,
                            widget.home.ownerId,
                          ),
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    SVGAssets.chat,
                    width: AppSize.s35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: buildMainAppBar(
        context,
        Text(
          widget.home.title,
          style: AppTextStyles.notificationsScreenTitleTextStyle(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: AppSize.s200,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                scrollPhysics: widget.home.imageUrls.length > 1
                    ? null
                    : const NeverScrollableScrollPhysics(),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: widget.home.imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppMargin.m5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: CachedImage(
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSize.s10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.home.imageUrls.length,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentIndex == index ? 12.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.grey
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "${_currentIndex + 1}/${widget.home.imageUrls.length}",
                  style: AppTextStyles.smallTitleTextStyle(context),
                ),
                const SizedBox(
                  width: AppSize.s16,
                )
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    ColorManager.primary.withOpacity(.1),
                    ColorManager.blue.withOpacity(.2),
                    ColorManager.blue.withOpacity(.4),
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppStrings.price.tr()} : ',
                            style:
                                AppTextStyles.homeDetailsDescriptionTextStyle(
                                    context),
                          ),
                          TextSpan(
                            text:
                                '${widget.home.price} ${AppStrings.priceHome.tr()}${widget.home.rentPeriod}',
                            style: AppTextStyles
                                .homeDetailsDescriptionContactTextStyle(
                                    context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppStrings.area.tr()} : ',
                            style:
                                AppTextStyles.homeDetailsDescriptionTextStyle(
                                    context),
                          ),
                          TextSpan(
                            text:
                                '${widget.home.area} ${AppStrings.meter.tr()}',
                            style: AppTextStyles
                                .homeDetailsDescriptionContactTextStyle(
                                    context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppStrings.paymentScreenTitle.tr()} : ',
                            style:
                                AppTextStyles.homeDetailsDescriptionTextStyle(
                                    context),
                          ),
                          TextSpan(
                            text: AppStrings.paymentCash.tr(),
                            style: AppTextStyles
                                .homeDetailsDescriptionContactTextStyle(
                                    context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeDetailsContent(
                            object: ' ${AppStrings.bedHome.tr()} ',
                            icon: SVGAssets.bed,
                            number: widget.home.numberOfBeds.toString(),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                          ),
                          HomeDetailsContent(
                            object: ' ${AppStrings.wifiHome.tr()} ',
                            icon: widget.home.wifiServices
                                ? SVGAssets.wifi
                                : Icons.wifi_off_outlined,
                            number: '',
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                          ),
                          HomeDetailsContent(
                            object: ' ${AppStrings.bathroomHome.tr()} ',
                            icon: SVGAssets.bathRoom,
                            number: widget.home.numberOfBathrooms.toString(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    Row(
                      children: [
                        Text(
                          '${AppStrings.homeDetailsRating.tr()} : ',
                          style: AppTextStyles.homeDetailsDescriptionTextStyle(
                              context),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              color: index < displayedRating
                                  ? Colors.orange.withOpacity(.7)
                                  : Colors.grey.withOpacity(.7),
                              size: AppSize.s35,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppStrings.description.tr()} : ',
                            style:
                                AppTextStyles.homeDetailsDescriptionTextStyle(
                                    context),
                          ),
                          TextSpan(
                            text: widget.home.description,
                            style: AppTextStyles
                                .homeDetailsDescriptionContactTextStyle(
                                    context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s15),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppStrings.location.tr()} : ',
                            style:
                                AppTextStyles.homeDetailsDescriptionTextStyle(
                                    context),
                          ),
                          TextSpan(
                            text: widget.home.location,
                            style: AppTextStyles
                                .homeDetailsDescriptionContactTextStyle(
                                    context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s15),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: AppSize.s170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              child: Image.asset(
                                ImageAssets.map,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              DataIntent.pushInitialLocation(
                                  widget.home.coordinates);
                              Navigator.pushNamed(
                                  context, Routes.homesMapRoute);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: AppSize.s50,
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorManager.error),
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                color: ColorManager.offwhite,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    SVGAssets.pin,
                                    width: AppSize.s30,
                                    colorFilter: const ColorFilter.mode(
                                        ColorManager.black, BlendMode.modulate),
                                  ),
                                  Text(
                                    AppStrings.seeLocation.tr(),
                                    style: AppTextStyles.homeGeneralTextStyle(
                                        context,
                                        ColorManager.black,
                                        FontSize.f18),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDetailsContent extends StatelessWidget {
  const HomeDetailsContent({
    super.key,
    required this.object,
    required this.icon,
    required this.number,
  });

  final String object;
  final dynamic icon;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (icon is String)
          SvgPicture.asset(
            icon,
            color: ColorManager.offwhite,
          )
        else if (icon is IconData)
          Icon(
            icon,
            color: ColorManager.offwhite,
          ),
        const SizedBox(
          width: AppSize.s2,
        ),
        Text(
          number,
          style: AppTextStyles.homeDetailsDescriptionContactTextStyle(context),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          object,
          style: AppTextStyles.homeDetailsDescriptionTextStyle(context),
        ),
      ],
    );
  }
}
