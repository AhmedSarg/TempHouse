import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 8, target: LatLng(30.47485747053768, 31.189873388919573));
    intiMarker();
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
            cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                northeast: LatLng(31.319573771437227, 34.24993346351709),
                southwest: LatLng(22.170822181359323, 24.999445544988394))),
            initialCameraPosition: initialCameraPosition,
          ),
          if (tappedMarker != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${tappedMarker!.infoWindow.snippet}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          Positioned(
            top: MediaQuery.of(context).size.height * .08,
            right: MediaQuery.of(context).size.width * .05,
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorManager.offwhite,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(AppSize.s8),
                      bottomLeft: Radius.circular(AppSize.s8))),
              child: IconButton(
                icon: SvgPicture.asset(
                  SVGAssets.location,
                  width: AppSize.s30,
                  height: AppSize.s30,
                ),
                onPressed: () {
                  googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(
                      LatLng(31.28740027455333, 30.02421947478106), 15));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  List<PlaceModel> places = [
    PlaceModel(1, 'Home 1', LatLng(30.47286017012721, 31.18171947364892),'01012951616','benha','شارع هاني علي كامل بجوار مستشفي الجامعه Fareed Nada Street, Banha, Al-Qalyubia Governorate 13511'),
    PlaceModel(2, 'Home 2', LatLng(30.084660155142792, 31.22542341623401),'0113492560','cairo', 'Corniche، النيل, Giza Governorate'),
    PlaceModel(3, 'Home 3', LatLng(31.212075763969697, 29.998351446306977),'0125828592','alex',   'Khorshid Al Qebleyah'),
    PlaceModel(4, 'Home 4', LatLng(24.085829684067846, 32.89478440574677),'0114091230','aswan',   'بجوار مستشفى النيل التخصصي، برج الاطباء, شارع كسر الحجر, Sheyakhah Thalethah, Aswan 1, Aswan Governorate 1242151'),
    PlaceModel(5, 'Home 5', LatLng(28.077208703415202, 30.71455257860048),'01012951616','sohag','3PCJ+465، تلة، مركز المنيا،, Minya, Minya Governorate'),
  ];

  void intiMarker() {
    var myMarkers = places
        .map(
          (place) => Marker(
        infoWindow: InfoWindow(
          snippet: place.name,
        ),
        position: place.latLng,
        markerId: MarkerId(place.id.toString()),
        onTap: () {
          setState(() {
            tappedMarker = markers.firstWhere(
                  (marker) => marker.markerId == MarkerId(place.id.toString()),
            );
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*.7,
                  padding: const EdgeInsets.all(AppPadding.p32),

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${tappedMarker!.infoWindow.snippet}',
                          style: AppTextStyles.googleMapHomeTitleTextStyle(),
                        ),
                        Text(
                          'House',
                          style: AppTextStyles.googleMapHomeTitleDescriptionTextStyle(),
                        ),
                        Text(
                          'Details',
                          style: AppTextStyles.googleMapHomeDetailsTitleTextStyle(),
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
                                    'Phone',
                                    style: AppTextStyles.googleMapHomeDetailsSubTitleTextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                  child: Text(
                                    '${place.phoneNumber}',
                                    style: AppTextStyles.googleMapHomeDetailsSubTitleContantTextStyle(),
                                  ),
                                ),
                                const Divider(color: ColorManager.grey,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                  child: Text(
                                    'Address',
                                    style: AppTextStyles.googleMapHomeDetailsSubTitleTextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                  child: Text(
                                    '${place.addres}',
                                    style: AppTextStyles.googleMapHomeDetailsSubTitleContantTextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                    'Description',
                                    style: AppTextStyles.googleMapHomeDetailsSubTitleTextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                  child: Text(
                                    '${place.description}',
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
          });
        },
      ),
    )
        .toSet();
    markers.addAll(myMarkers);
  }
}
