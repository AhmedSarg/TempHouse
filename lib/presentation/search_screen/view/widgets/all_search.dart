import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/search_home_item.dart';

import '../../../common/widget/main_circle_processIndicator.dart';
import '../../../common/widget/main_seach_field.dart';
import '../../../main_layout/pages/home_details/home_details.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';

class AllSearch extends StatefulWidget {
  const AllSearch({Key? key}) : super(key: key);

  @override
  State<AllSearch> createState() => _AllSearchState();
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
          width: MediaQuery.of(context).size.width * .9,
          child: MainSearch(
            controller: _searchController,
            hintText: AppStrings.searchTextHint.tr(),
            leadingIcon: Icons.search,
            trailingIcon: SvgPicture.asset(SVGAssets.googleMaps),
            onChanged: (value) {
              setState(
                () {
                  if (value.isEmpty) {
                    _searchStream = FirebaseFirestore.instance
                        .collection('Homes')
                        .snapshots();
                  } else {
                    _searchStream = FirebaseFirestore.instance
                        .collection('Homes')
                        .where('description',
                            isGreaterThanOrEqualTo: value.toLowerCase())
                        .snapshots();
                  }
                },
              );
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _searchStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MainCicleProcessIndicator();
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(); // Return an empty container if no data or no search results
              }
              final items =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
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
