import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/domain.dart';
import '../../domain/models/enums.dart';
import '../../domain/repository/repository.dart';
import '../data_source/cache_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  final CacheDataSource _cacheDataSource;
  final NetworkInfo _networkInfo;

  final Uuid _uuidGenerator = const Uuid();

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._cacheDataSource,
  );

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
          coordinates: coordinates,
          name: name,
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
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String? job,
    required int? salary,
    required int age,
    required String? martialStatus,
    required UserRole userType,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String uuid = _uuidGenerator.v1();
        if (userType == UserRole.tenant) {
          await _remoteDataSource.registerTenantToDataBase(
            uuid: uuid,
            phoneNumber: phoneNumber,
            email: email,
            username: username,
            gender: gender,
            job: job!,
            salary: salary!,
            age: age,
            martialStatus: martialStatus!,
          );
        } else {
          await _remoteDataSource.registerOwnerToDataBase(
            uuid: uuid,
            phoneNumber: phoneNumber,
            email: email,
            username: username,
            gender: gender,
            age: age,
          );
        }
        await fetchCurrentUser(email);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.login(email: email, password: password);
        //todo remove the 8 lines below
        return await fetchCurrentUser(email).then(
          (value) {
            return value.fold(
              (l) => Left(l),
              (r) => const Right(null),
            );
          },
        );
        //todo uncomment the 2 lines below
        //await fetchCurrentUser(email);
        //return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<HomeModel>>>> getAllHomes() async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<HomeModel>> homesStream =
            await _remoteDataSource.getAllHomes().then(
          (stream) {
            return stream.map(
              (homes) {
                return homes.map(
                  (home) {
                    return HomeModel.fromMap(home);
                  },
                ).toList();
              },
            );
          },
        );
        return Right(homesStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> calculateTwoPoints({
    required LatLng pointA,
    required LatLng pointB,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Map<String, dynamic> res =
            await _remoteDataSource.calculateTwoPoints(pointA, pointB);
        return Right(res);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites({
    required String userId,
    required String homeId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addToFavorites(userId: userId, homeId: homeId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites({
    required String userId,
    required String homeId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.removeFromFavorites(
          userId: userId,
          homeId: homeId,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<Future<HomeModel>>>>> getAllFavorites({
    required String userId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<Future<HomeModel>>> favoriteHomesStream =
            await _remoteDataSource
                .getAllFavorites(
          userId: userId,
        )
                .then(
          (homesStream) {
            return homesStream.map(
              (homes) {
                return homes.map(
                  (homeId) async {
                    final home = await _remoteDataSource.getHomeById(
                      homeId: homeId,
                    );
                    return HomeModel.fromMap(home);
                  },
                ).toList();
              },
            );
          },
        );
        return Right(favoriteHomesStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, User?>> fetchCurrentUser(
      [String email = 'xsarg221@gmail.com']) async {
    try {
      if (await _networkInfo.isConnected) {
        //todo uncomment the 2 lines below
        // var data = _cacheDataSource.getSignedUser();
        // if (data != null) {
        Map<String, dynamic>? userData = await _remoteDataSource.getUserData(
          email: email,
          //todo uncomment the line below and remove the line above
          //email: data.email!,
        );
        //todo remove the line below
        if (userData != null) {
          UserModel userModel = UserModel.fromMap(userData!);
          DataIntent.pushUser(userModel);
          if (userData['user_type'].toLowerCase() == 'owner') {
            DataIntent.setUserRole(UserRole.owner);
          } else {
            DataIntent.setUserRole(UserRole.tenant);
          }
          //todo remove the line below
          return Right(FakeUser());
        }
        //todo remove the 3 lines below
        else {
          return Left(DataSource.EMAIL_LOGIN_FAILED.getFailure());
        }
        //todo uncomment the line below
        //return Right(data);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.reportHome(
          userId: userId,
          homeId: homeId,
          report: report,
          submittedAt: submittedAt,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> changeAccountInfo({
    required String userId,
    required bool emailChanged,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        RegisteredBeforeError? registeredBeforeError;
        if (emailChanged) {
          registeredBeforeError =
              await _remoteDataSource.doesUserExists(email: email);
        } else {
          registeredBeforeError = null;
        }
        if (registeredBeforeError == null) {
          await _remoteDataSource.changeAccountInfo(
            userId: userId,
            email: email,
            phoneNumber: phoneNumber,
            pictureChanged: pictureChanged,
            picture: picture,
          );
          await fetchCurrentUser(email);
          return const Right(null);
        } else {
          return Left(DataSource.EMAIL_ALREADY_EXISTS.getFailure());
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addPaymentCard(
          userId: userId,
          cardName: cardName,
          cardNumber: cardNumber,
          cardExpirationDate: cardExpirationDate,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}

//todo remove this class
class FakeUser implements User {
  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  String? get displayName => throw UnimplementedError();

  @override
  String? get email => throw UnimplementedError();

  @override
  bool get emailVerified => throw UnimplementedError();

  @override
  Future<String?> getIdToken([bool forceRefresh = false]) {
    throw UnimplementedError();
  }

  @override
  Future<IdTokenResult> getIdTokenResult([bool forceRefresh = false]) {
    throw UnimplementedError();
  }

  @override
  bool get isAnonymous => throw UnimplementedError();

  @override
  Future<UserCredential> linkWithCredential(AuthCredential credential) {
    throw UnimplementedError();
  }

  @override
  Future<ConfirmationResult> linkWithPhoneNumber(String phoneNumber,
      [RecaptchaVerifier? verifier]) {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> linkWithPopup(AuthProvider provider) {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> linkWithProvider(AuthProvider provider) {
    throw UnimplementedError();
  }

  @override
  Future<void> linkWithRedirect(AuthProvider provider) {
    throw UnimplementedError();
  }

  @override
  UserMetadata get metadata => throw UnimplementedError();

  @override
  MultiFactor get multiFactor => throw UnimplementedError();

  @override
  String? get phoneNumber => throw UnimplementedError();

  @override
  String? get photoURL => throw UnimplementedError();

  @override
  List<UserInfo> get providerData => throw UnimplementedError();

  @override
  Future<UserCredential> reauthenticateWithCredential(
      AuthCredential credential) {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> reauthenticateWithPopup(AuthProvider provider) {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> reauthenticateWithProvider(AuthProvider provider) {
    throw UnimplementedError();
  }

  @override
  Future<void> reauthenticateWithRedirect(AuthProvider provider) {
    throw UnimplementedError();
  }

  @override
  String? get refreshToken => throw UnimplementedError();

  @override
  Future<void> reload() {
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification([ActionCodeSettings? actionCodeSettings]) {
    throw UnimplementedError();
  }

  @override
  String? get tenantId => throw UnimplementedError();

  @override
  String get uid => throw UnimplementedError();

  @override
  Future<User> unlink(String providerId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDisplayName(String? displayName) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmail(String newEmail) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(String newPassword) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhoneNumber(PhoneAuthCredential phoneCredential) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhotoURL(String? photoURL) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyBeforeUpdateEmail(String newEmail,
      [ActionCodeSettings? actionCodeSettings]) {
    throw UnimplementedError();
  }
}
