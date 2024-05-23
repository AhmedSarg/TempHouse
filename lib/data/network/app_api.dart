import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// part 'app_api.g.dart';
//
// @RestApi(baseUrl: Constants.baseUrl)
// abstract class AppServiceClient {
//   factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
//
//   @POST("/API/scanQR_app.php")
//   Future<ScanCodeResponse> scan(@Field("code") String code);
// }

// const String _newsEndPoint = "/API/news.php";

abstract class AppServiceClient {
  // Future<NewsListResponse> getNews();

  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pickup, LatLng destination);
}

class AppServiceClientImpl implements AppServiceClient {
  final Dio _dio;

  AppServiceClientImpl(this._dio);

  // @override
  // Future<NewsListResponse> getNews() async {
  //   Response response = await _dio.post(
  //     _newsEndPoint,
  //   );
  //
  //   var data = const Utf8Codec().decode(response.data).toString();
  //   return NewsListResponse.fromJson(jsonDecode(data));
  // }

  @override
  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pointA, LatLng pointB) async {
    const String baseUrl = "https://router.hereapi.com/v8/";
    const String apiKey = "Vc6Uhd34IMqaeQskoAJOIGbVv2RzpWgrO07T9WYuM9s";
    const String endpoint = "routes";
    const String url = baseUrl + endpoint;
    Map<String, dynamic> result = {"data": -1};
    await _dio.get(url, queryParameters: {
      "apiKey": apiKey,
      "transportMode": "car",
      "origin": "${pointA.latitude},${pointA.longitude}",
      "destination": "${pointB.latitude},${pointB.longitude}",
      "return": "summary,polyline",
    }).then((value) {
      double time =
          value.data["routes"][0]["sections"][0]["summary"]["duration"] / 60;
      int distance =
          value.data["routes"][0]["sections"][0]["summary"]["length"];
      String polylineCode = value.data["routes"][0]["sections"][0]["polyline"];
      result = {
        "time": time.round(),
        "distance": distance,
        "polylineCode": polylineCode,
      };
    });
    return result;
  }
}
