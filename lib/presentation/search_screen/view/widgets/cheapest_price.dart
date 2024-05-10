import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/search_home_item.dart';

import '../../../common/widget/main_circle_processIndicator.dart';
import '../../../main_layout/pages/home_details/home_Details.dart';
import '../../../main_layout/pages/home_screen/view/widgets/near_by_home_item.dart';
import '../../../resources/color_manager.dart';

class CheapestSearch extends StatelessWidget {
  const CheapestSearch({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Homes').orderBy('price').snapshots(),
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
          final Map<String, dynamic> data =
          document.data()! as Map<String, dynamic>;
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
                    name: data['name'],
                    coardinaties: data['coordinates'],                    rating: data['rating']??0,
                    numberOfRatings:data['numberOfRatings']??0,

                  ),
                ),
              );
            },
            child: SearchHomeItem(
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
              coardinaties: data['coordinates'], rating: data['rating']??0,
              numberOfRatings:data['numberOfRatings']??0,
            ),
          );
        }).toList();

        return ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent: 22,
              thickness: .5,
              endIndent: 22,
              color: Colors.grey,
            );
          },
        );
      },
    );
  }
}
