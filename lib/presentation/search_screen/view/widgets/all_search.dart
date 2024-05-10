import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/search_home_item.dart';

import '../../../common/widget/main_circle_processIndicator.dart';
import '../../../common/widget/main_seach_field.dart';
import '../../../main_layout/pages/home_details/home_Details.dart';
import '../../../main_layout/pages/home_screen/view/widgets/near_by_home_item.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class AllSearch extends StatefulWidget {
  const AllSearch({Key? key}) : super(key: key);

  @override
  _AllSearchState createState() => _AllSearchState();
}

class _AllSearchState extends State<AllSearch> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot> _searchStream;

  @override
  void initState() {
    super.initState();
    _searchStream = FirebaseFirestore.instance.collection('Homes').snapshots();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*.9,
          child: MainSearch(
            controller: _searchController,
            hintText: AppStrings.searchTextHint.tr(),
            leadingIcon: Icons.search,
            trailingIcon:Padding(
              padding: const EdgeInsets.all(  AppPadding.p8),
              child: SvgPicture.asset(
                SVGAssets.googleMaps,
                width: AppSize.s20,
                height: AppSize.s20,
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _searchStream = FirebaseFirestore.instance.collection('Homes').snapshots();
                } else {
                  _searchStream = FirebaseFirestore.instance.collection('Homes')

                      .where('description', isGreaterThanOrEqualTo: value.toLowerCase())
                      .snapshots();
                }
              });
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _searchStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MainCicleProcessIndicator();
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(); // Return an empty container if no data or no search results
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
                          numberOfRatings:data['numberOfRatings']??0,
                          coardinaties: data['coordinates'],                    rating: data['rating']??0,

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
                    coardinaties: data['coordinates'],
                    rating: data['rating']??0,
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
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
