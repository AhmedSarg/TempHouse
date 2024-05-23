import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  final String phoneNumber;
  final String address;
  final String description;

  PlaceModel(
    this.id,
    this.name,
    this.latLng,
    this.phoneNumber,
    this.address,
    this.description,
  );
}

class HomeModel {
  final String title;
  final String homeId;
  final String ownerId;
  final String ownerName;
  final num price;
  final String location;
  final String imageUrl;
  final List<dynamic> imageUrls;
  final int numberOfBeds;
  final bool wifiServices;
  final int numberOfBathrooms;
  final DateTime date;
  final String description;
  final int area;
  final LatLng coordinates;
  final double rate;
  final int numberOfRates;
  final String rentPeriod;

  HomeModel({
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.imageUrls,
    required this.numberOfBeds,
    required this.wifiServices,
    required this.numberOfBathrooms,
    required this.date,
    required this.description,
    required this.area,
    required this.coordinates,
    required this.homeId,
    required this.ownerId,
    required this.ownerName,
    required this.rate,
    required this.numberOfRates,
    required this.rentPeriod,
  });

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      title: map['title'],
      price: map['price'],
      location: map['location'],
      imageUrl: map['images'][0],
      imageUrls: map['images'],
      numberOfBeds: map['number_of_beds'],
      wifiServices: map['wifi'],
      numberOfBathrooms: map['number_of_bathrooms'],
      date: map['timestamp'].toDate(),
      description: map['description'],
      area: map['area'].toInt(),
      coordinates: LatLng(
        map['coordinates'].latitude,
        map['coordinates'].longitude,
      ),
      homeId: map['uuid'],
      ownerId: map['owner_id'],
      ownerName: map['name'],
      rate: map['rating'].toDouble(),
      numberOfRates: map['numberOfRatings'],
      rentPeriod: map['category'],
    );
  }
}

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;
  final Gender gender;
  final int age;
  final String imageUrl;
  final String? currentJob;
  final int? currentSalary;
  final String? martialStatus;
  final UserRole userRole;
  final List<dynamic> favoriteHomes;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.age,
    required this.imageUrl,
    this.currentJob,
    this.currentSalary,
    this.martialStatus,
    required this.userRole,
    required this.favoriteHomes,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    UserRole userRole;
    if (map['user_type'].toLowerCase() == 'owner') {
      userRole = UserRole.owner;
    } else {
      userRole = UserRole.tenant;
    }
    Gender gender;
    if (map['gender'].toLowerCase() == 'female') {
      gender = Gender.female;
    } else {
      gender = Gender.male;
    }
    return UserModel(
      uid: map['id'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      gender: gender,
      age: map['age'],
      imageUrl: map['image_path'] ?? ImageAssets.unknownUserImage,
      currentJob: map['current_job'],
      currentSalary: map['current_salary'],
      martialStatus: map['martial_status'],
      userRole: userRole,
      favoriteHomes: map['favorites'],
    );
  }

  addHomeToFavorites(String homeId) {
    favoriteHomes.add(homeId);
  }

  removeHomeFromFavorites(String homeId) {
    favoriteHomes.remove(homeId);
  }

  bool isHomeInFavorites(String homeId) {
    return favoriteHomes.contains(homeId);
  }
}
