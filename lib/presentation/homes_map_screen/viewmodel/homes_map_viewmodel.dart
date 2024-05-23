import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/usecase/report_home_usecase.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import '../../../app/sl.dart';
import '../../../domain/models/domain.dart';
import '../../../domain/usecase/get_all_homes_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';
import 'states/homes_map_states.dart';

class HomesMapViewModel extends BaseCubit
    implements HomesMapViewModelInput, HomesMapViewModelOutput {
  static HomesMapViewModel get(context) => BlocProvider.of(context);

  late final LatLng? _initialLocation;

  final GetAllHomesUseCase _getAllHomesUseCase = sl<GetAllHomesUseCase>();

  final ReportHomeUseCase _reportHomeUseCase = sl<ReportHomeUseCase>();

  late final GoogleMapController _mapController;

  final TextEditingController _reportController = TextEditingController();

  late LatLng _userLocation;

  final List<HomeModel> _homesList = [];

  final Set<Marker> _homesMarkers = {};

  BitmapDescriptor? _pin;

  _fetchUserLocation() async {
    Position userPosition = await Geolocator.getCurrentPosition();
    _userLocation = LatLng(userPosition.latitude, userPosition.longitude);
  }

  goToMyLocation() {
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_userLocation),
    );
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size.square(AppSize.s60),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio =
        PlatformDispatcher.instance.views.first.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = PictureRecorder();

    Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  Future<void> _fetchPinIcon() async {
    _pin = await _bitmapDescriptorFromSvgAsset(SVGAssets.mapHome);
  }

  Future<void> _getAllHomes() async {
    await _getAllHomesUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, textColor: ColorManager.black));
          },
          (r) {
            r.listen(
              (homes) {
                _homesList.clear();
                _homesMarkers.clear();
                for (HomeModel home in homes) {
                  _homesList.add(home);
                  _homesMarkers.add(
                    Marker(
                      markerId: MarkerId(home.homeId),
                      icon: _pin!,
                      position: home.coordinates,
                      onTap: () {
                        emit(HomeClickedState(home));
                      },
                    ),
                  );
                }
                emit(ContentState());
              },
            );
          },
        );
      },
    );
  }

  showReportHome() {
    emit(HomeReportState());
  }

  Future<void> reportHome(String homeId) async {
    await _reportHomeUseCase(
      ReportHomeUseCaseInput(
        userId: DataIntent.getUser().uid,
        homeId: homeId,
        report: _reportController.text,
        submittedAt: DateTime.now(),
      ),
    ).whenComplete(() {
      _reportController.clear();
    });
  }

  @override
  void start() async {
    emit(LoadingState());
    _initialLocation = DataIntent.popInitialLocation();
    await _fetchUserLocation();
    await _fetchPinIcon();
    _getAllHomes();
  }

  @override
  set setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  LatLng get getUserLocation => _userLocation;

  @override
  LatLng? get getInitialLocation => _initialLocation;

  @override
  List<HomeModel> get getHomesList => _homesList;

  @override
  Set<Marker> get getHomesMarkers => _homesMarkers;

  @override
  TextEditingController get getReportController => _reportController;
}

abstract class HomesMapViewModelInput {
  set setMapController(GoogleMapController controller);
}

abstract class HomesMapViewModelOutput {
  LatLng get getUserLocation;

  LatLng? get getInitialLocation;

  List<HomeModel> get getHomesList;

  Set<Marker> get getHomesMarkers;

  TextEditingController get getReportController;
}
