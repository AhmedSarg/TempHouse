import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../../home_details/home_details.dart';
import 'home_list_view_item.dart';
import 'no_homes_available.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Homes').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          NoHomesAvailable(
            text: AppStrings.noHomesAvailable.tr(),
          );
        }

        final items = snapshot.data!.docs.map(
          (DocumentSnapshot document) {
            final Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
            List<dynamic> images = data['images'] ?? [];
            String firstImage = images.isNotEmpty ? images[0] : '';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeDetailsScreen(
                      home: HomeModel.fromMap(data),
                    ),
                  ),
                );
              },
              child: BuildCarouselItem(
                home: HomeModel.fromMap(data),
              ),
            );
          },
        ).toList();

        return CarouselSlider(
          options: CarouselOptions(
            height: 350,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            disableCenter: true,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 0.7,
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            initialPage: 0,
          ),
          items: items,
        );
      },
    );
  }
}
