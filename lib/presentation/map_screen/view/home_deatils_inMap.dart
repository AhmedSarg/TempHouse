import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class GoogleMapHomeDetailsScreen extends StatefulWidget {
  const GoogleMapHomeDetailsScreen({Key? key, this.coordinates, required this.title, required this.address, required this.description}) : super(key: key);
  final GeoPoint? coordinates;
final String title;
final String address;
final String description;
  @override
  State<GoogleMapHomeDetailsScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapHomeDetailsScreen> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;

  @override
  void initState() {
    if (widget.coordinates != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(widget.coordinates!.latitude, widget.coordinates!.longitude),
        zoom: 19,
      );
    } else {
      initialCameraPosition = const CameraPosition(
        target: LatLng(30.47485747053768, 31.189873388919573),
        zoom: 8,
      );
    }

    markers.add(Marker(
      markerId: const MarkerId('initial_position'),
      position: initialCameraPosition.target,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(AppPadding.p32),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (tappedMarker != null)
                      Text(
                        '${tappedMarker!.infoWindow.snippet}',
                        style: AppTextStyles.googleMapHomeTitleTextStyle(),
                      ),
                    Text(
                      AppStrings.homeDetails.tr(),
                      style: AppTextStyles.googleMapHomeTitleDescriptionTextStyle(),
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Text(
                                AppStrings.title.tr(),
                                style: AppTextStyles.googleMapHomeDetailsSubTitleTextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Text(
                                widget.title,
                                style: AppTextStyles.googleMapHomeDetailsSubTitleContantTextStyle(),
                              ),
                            ),
                            const Divider(color: ColorManager.grey,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Text(
                                AppStrings.location.tr(),
                                style: AppTextStyles.googleMapHomeDetailsSubTitleTextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Text(
                                widget.address,
                                style: AppTextStyles.googleMapHomeDetailsSubTitleContantTextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Text(
                                AppStrings.description.tr(),
                                style: AppTextStyles.googleMapHomeDetailsSubTitleTextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Text(
                                widget.description,
                                style: AppTextStyles.googleMapHomeDetailsSubTitleContantTextStyle(),
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
          },
        );
      },
    ));

    super.initState();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  Marker? tappedMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
          ),
        ],
      ),
    );
  }

}
