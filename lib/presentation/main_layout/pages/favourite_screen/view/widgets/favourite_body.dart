import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/near_by_home_item.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Favorites')
          .doc(DataIntent.getUser().uid)
          .collection('items')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No favorite items available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            if (data == null) {
              return const SizedBox();
            }

            return NearByHomeItem(
              key: Key(doc.id),
              color: ColorManager.offwhite,
              title: data['title'] ?? '',
              price: data['price'] ?? 0,
              location: data['location'] ?? '',
              imageUrl: data['imageUrl'] ?? '',
              numnerofBeds: data['number_of_beds']?.toString() ?? '',
              wifiServices: data['wifi'] == true ? 'Yes' : 'No',
              numnerofbathroom: data['number_of_bathrooms']?.toString() ?? '',
              date: data['category'] ?? '',
              id: doc.id,
              description: data['description']  ?? '',
              coardinaties: data['coordinates'] ?? GeoPoint(0, 0),rating: data['rating']??0,
              numberOfRatings:data['numberOfRatings']??0,
            );
          },
        );
      },
    );
  }
}