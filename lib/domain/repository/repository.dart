import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';

abstract class Repository {

  // Future<Either<Failure, void>> register({
  //   required String username,
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required String gender,
  //   required String age,
  //   required String maritalStatus,
  //   required DateTime? createdAt,
  //   required RegisterType registerType,
  // });


  Future<Either<Failure, void>> sharePost({
    required String title,
    required String name,
    required num price,
    required num area,
    required String category,
    required String condition,
    required int numberOfBeds,
    required bool wifi,
    required int numberOfBathrooms,
    required String description,
    required String location,
    required List<File> images,
    required GeoPoint coordinates,
  });

  Future<Either<Failure, void>> register({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String? job,
    required num? salary,
    required num age,
    required String martialStatus,
    required RegisterType registerType,
  });


}
