import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chat_screen/view/chat_view.dart';
import 'package:temp_house/presentation/common/widget/cached_image.dart';
import 'package:temp_house/presentation/map_screen/view/home_deatils_inMap.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/share_post_screen/viewmodel/share_view_model.dart';
import '../../../common/data_intent/data_intent.dart';
import '../../../common/widget/main_app_bar.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../home_screen/view/widgets/home_listView_iItem.dart';

class HomeDetailsScreen extends StatefulWidget {
  final String id;
  final String title;
  final String name;
  final num price;
  final num numberOfRatings;
  final num rating;
  final num area;
  final String location;
  final List<String> imageUrls;
  final String numnerofBeds;
  final String wifiServices;
  final String numnerofbathroom;
  final String description;
  final String period;
  final GeoPoint coardinaties;

  const HomeDetailsScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrls,
    required this.numnerofBeds,
    required this.wifiServices,
    required this.numnerofbathroom,
    required this.id,
    required this.description,
    required date,
    required this.period,
    required this.area,
    required this.coardinaties,
    required this.name, required this.rating, required this.numberOfRatings,
  }) : super(key: key);

  @override
  _HomeDetailsScreenState createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int _currentIndex = 0;
  double _rating = 2.4;
ChatServices chatServices = ChatServices();
  @override
  Widget build(BuildContext context) {
    int rating = widget.rating.toInt();
    print(rating);
    print('________________________________');
    final int displayedRating = (widget.rating / widget.numberOfRatings).clamp(0, 5).floor();

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
                      backgroundColor: MaterialStateProperty.all<Color>(
                    ColorManager.blue.withOpacity(.7),
                  )),
                  onPressed: () {


                    if (chatServices.getChatRoomID(DataIntent.getUser().uid, widget.id)==chatServices.getChatRoomID( widget.id,DataIntent.getUser().uid)) {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            receiveEmail: widget.name,
                            receiveID: widget.id,
                            chatID: chatServices.getChatRoomID(DataIntent.getUser().uid, widget.id),
                          ),
                        ),);

                    }else{
                      String chatID = chatServices.getChatRoomID(DataIntent.getUser().uid, widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              receiveEmail: widget.name,
                              receiveID: widget.id,
                              chatID: chatID),
                        ),
                      );

                    }

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
          widget.title,
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
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: widget.imageUrls.map((imageUrl) {
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
              children: List.generate(widget.imageUrls.length, (index) {
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
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "${_currentIndex + 1}/${widget.imageUrls.length}",
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
                                AppTextStyles.homeDetailsDescriptionTextStyle(),
                          ),
                          TextSpan(
                            text:
                                '${widget.price} ${AppStrings.priceHome.tr()}${widget.period}',
                            style: AppTextStyles
                                .homeDetailsDescriptionContantTextStyle(),
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
                                AppTextStyles.homeDetailsDescriptionTextStyle(),
                          ),
                          TextSpan(
                            text: '${widget.area} ${AppStrings.meter.tr()}',
                            style: AppTextStyles
                                .homeDetailsDescriptionContantTextStyle(),
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
                                AppTextStyles.homeDetailsDescriptionTextStyle(),
                          ),
                          TextSpan(
                            text: AppStrings.paymentCash.tr(),
                            style: AppTextStyles
                                .homeDetailsDescriptionContantTextStyle(),
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
                            number: widget.numnerofBeds,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                          ),
                          HomeDetailsContent(
                            object: ' ${AppStrings.wifiHome.tr()} ',
                            icon: widget.wifiServices ==
                                    AppStrings.wifiServicesYes.tr()
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
                            number: widget.numnerofbathroom,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    Row(
                      children: [
                        Text(
                          '${AppStrings.homeDetailsRating.tr()} : ',
                          style:
                              AppTextStyles.homeDetailsDescriptionTextStyle(),
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
                                AppTextStyles.homeDetailsDescriptionTextStyle(),
                          ),
                          TextSpan(
                            text: widget.description,
                            style: AppTextStyles
                                .homeDetailsDescriptionContantTextStyle(),
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
                                AppTextStyles.homeDetailsDescriptionTextStyle(),
                          ),
                          TextSpan(
                            text: widget.location,
                            style: AppTextStyles
                                .homeDetailsDescriptionContantTextStyle(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GoogleMapHomeDetailsScreen(
                                    coordinates: widget.coardinaties,
                                    title: widget.title,
                                    address: widget.location,
                                    description: widget.description,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: AppSize.s50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.error),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                  color: ColorManager.offwhite),
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
                                    style: AppTextStyles.homegenertalTextStyle(
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
    Key? key,
    required this.object,
    required this.icon,
    required this.number,
  }) : super(key: key);

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
          style: AppTextStyles.homeDetailsDescriptionContantTextStyle(),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          object,
          style: AppTextStyles.homeDetailsDescriptionTextStyle(),
        ),
      ],
    );
  }
}
