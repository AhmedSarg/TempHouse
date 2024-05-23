import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/search_home_item.dart';

import '../../../../domain/models/domain.dart';
import '../../../common/widget/main_circle_processIndicator.dart';
import '../../../main_layout/pages/home_details/home_details.dart';

class LeatestSearch extends StatelessWidget {
  const LeatestSearch({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Homes')
          .orderBy('timestamp', descending: true)
          .snapshots(),
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
                    home: HomeModel.fromMap(data),
                  ),
                ),
              );
            },
            child: SearchHomeItem(
              home: HomeModel.fromMap(data),
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
