import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import '../../../home_details/home_Details.dart';
import 'home_listView_iItem.dart';
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
            text: AppStrings.NoHomesAvailable.tr(),
          );
        }

        final items = snapshot.data!.docs.map((DocumentSnapshot document) {
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
                    id: document.id,
                    imageUrls: images.cast<String>(),
                    title: data['title'],
                    name: data['name'],
                    price: data['price'],
                    area: data['area'],
                    numnerofBeds: data['number_of_beds'].toString(),
                    wifiServices: data['wifi'] == true ? 'Yes' : 'No',
                    numnerofbathroom: data['number_of_bathrooms'].toString(),
                    date: data['category'],
                    description: data['description'],
                    location: data['location'],
                    period: data['category'],
                    coardinaties:data['coordinates'],
                    numberOfRatings:data['numberOfRatings']??0,
                    rating: data['rating']??0,
                  ),
                ),
              );
            },
            child: BuildCarouselItem(
              color: ColorManager.offwhite,
              title: data['title'],
              price: data['price'],
              location: data['location'],
              imageUrl: firstImage,
              numnerofBeds: data['number_of_beds'].toString(),
              wifiServices: data['wifi'] == true ? 'Yes' : 'No',
              numnerofbathroom: data['number_of_bathrooms'].toString(),
              date: data['category'],
              id: data['uuid'],
              description: data['description'],
              coardinaties:data['coordinates'],
              rating: data['rating']??0,
              numberOfRatings:data['numberOfRatings']??0,
            ),
          );
        }).toList();

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
