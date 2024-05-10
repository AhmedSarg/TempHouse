// import 'dart:io';
//
// import 'package:dartz/dartz.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../data/network/error_handler.dart';
// import '../../data/network/failure.dart';
// import '../repository/repository.dart';
// import 'base_usecase.dart';
//
// class SharePostAndManageFavoritesUseCase
//     extends BaseUseCase<SharePostAndManageFavoritesUseCaseInput, void>  {
//   final Repository repository;
//
//   SharePostAndManageFavoritesUseCase(this.repository);
//
//   @override
//   Future<Either<Failure, void>> addToFavorites(
//       String userId, String homeId) async {
//     try {
//       final result = await repository.addToFavorites(userId, homeId);
//       return result;
//     } catch (e) {
//       return Left(ErrorHandler.handle(e).failure);
//     }
//   }
//
//   @override
//   Future<Either<Failure, void>> removeFromFavorites(
//       String userId, String homeId) async {
//     try {
//       final result = await repository.removeFromFavorites(userId, homeId);
//       return result;
//     } catch (e) {
//       return Left(ErrorHandler.handle(e).failure);
//     }
//   }
//
//   @override
//   Future<Either<Failure, void>> call(input) {
//     // TODO: implement call
//     throw UnimplementedError();
//   }
//
//
// }
// class SharePostAndManageFavoritesUseCaseInput {
//
//
// }
