import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widget/main_circle_processIndicator.dart';
import '../../../../../resources/color_manager.dart';
import '../../../home_details/home_Details.dart';
import 'near_by_home_item.dart';

class NearByHomeList extends StatelessWidget {
  const NearByHomeList({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Homes').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Text('No data available');
        }

        final items = snapshot.data!.docs.map((DocumentSnapshot document) {
          final Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
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
                    name: data['name'],
                    numberOfRatings:data['numberOfRatings']??0,
                    rating: data['rating']??0,

                  ),
                ),
              );
            },

            child: NearByHomeItem(
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
              coardinaties:data['coordinates'], rating: data['rating']??0,
              numberOfRatings:data['numberOfRatings']??0,

            ),
          );
        }).toList();
       return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
         itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisExtent: 135,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,

          ),
         itemBuilder: (context, index) {
           return items[index];
         },
       );
        // return ListView.separated(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //
        //   itemCount: items.length,
        //   itemBuilder: (context, index) {
        //     return items[index];
        //   },
        //   separatorBuilder: (BuildContext context, int index) {
        //     return const Divider(
        //       indent: 22,
        //       thickness: .5,
        //       endIndent: 22,
        //       color: Colors.grey,
        //     );
        //   },
        // );
      },
    );
  }
}
