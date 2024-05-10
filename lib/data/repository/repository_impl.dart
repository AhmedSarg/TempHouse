import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/enums.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  // final LocalDataSource _localDataSource;
  // final CacheDataSource _cacheDataSource;
  final NetworkInfo _networkInfo;
  // final Uuid _uuidGenerator = const Uuid();
  final Uuid _uuidGenerator = const Uuid();

  RepositoryImpl(
    this._remoteDataSource,
    // this._localDataSource,
    this._networkInfo,
    // this._cacheDataSource,
  );

  // @override
  // Future<Either<Failure, void>> register({
  //   required String username,
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required String gender,
  //   required String age,
  //   required String maritalStatus,
  //   required DateTime createdAt,
  //   required RegisterType registerType,
  // }) async {
  //   try {
  //     if (await _networkInfo.isConnected) {
  //       // String uuid = _uuidGenerator.v1();
  //
  //       if (registerType == RegisterType.owner) {
  //         await _remoteDataSource.registerOwnerToDataBase(
  //           uuid: uuid,
  //           createdAt: DateTime.now(),
  //           username: username,
  //           email: email,
  //           password: password,
  //           phoneNumber: phoneNumber,
  //           gender: gender,
  //           age: age,
  //           maritalStatus: maritalStatus,
  //         );
  //       } else {
  //         await _remoteDataSource.registerTenantToDataBase(
  //           uuid: uuid,
  //           createdAt: DateTime.now(),
  //           username: username,
  //           email: email,
  //           password: password,
  //           phoneNumber: phoneNumber,
  //           gender: gender,
  //           age: age,
  //           maritalStatus: maritalStatus,
  //         );
  //       }
  //       return const Right(null);
  //     } else {
  //       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  //     }
  //   } catch (e) {
  //     return Left(ErrorHandler.handle(e).failure);
  //   }
  // }

  @override
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
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String homeId = await _remoteDataSource.saveHomesToDateBase(
          title: title,
          price: price,
          area: area,
          category: category,
          condition: condition,
          numberOfBeds: numberOfBeds,
          wifi: wifi,
          numberOfBathrooms: numberOfBathrooms,
          description: description,
          location: location,
          coordinates: coordinates, name: name,
        );
        await _remoteDataSource.uploadImages(images, homeId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }



  @override
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
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String uuid = _uuidGenerator.v1();
        if (registerType == RegisterType.tenant) {
          await _remoteDataSource.registerTenantToDataBase(
            uuid: uuid,

            phoneNumber: phoneNumber,
            email: email, username: username, gender: gender, job: job, salary: salary, age: age, martialStatus: martialStatus,

          );
        } else {
          await _remoteDataSource.registerOwnerToDataBase(
            uuid: uuid,

            phoneNumber: phoneNumber,
            email: email, username: username, gender: gender, age: age, martialStatus: martialStatus,

          );
        }
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
