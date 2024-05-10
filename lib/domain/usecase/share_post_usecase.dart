import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SharePostUseCase extends BaseUseCase<SharePostUseCaseInput, void> {
  final Repository _repository;

  SharePostUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(SharePostUseCaseInput input) async {
    return _repository.sharePost(
      title: input.title,
      name: input.name,
      price: input.price,
      area: input.area,
      category: input.category,
      condition: input.condition,
      numberOfBeds: input.numberOfBeds,
      wifi: input.wifi,
      numberOfBathrooms: input.numberOfBathrooms,
      description: input.description,
      location: input.location,
      images: input.images,
      coordinates: input.coordinates,

    );
  }
}

class SharePostUseCaseInput {
  final String title;
  final String name;
  final num price;
  final num area;
  final String category;
  final String condition;
  final int numberOfBeds;
  final bool wifi;
  final int numberOfBathrooms;
  final String description;
  final String location;
  final List<File> images;
  final GeoPoint coordinates;

  SharePostUseCaseInput(    {
    required this.name,
    required this.title,
    required this.price,
    required this.area,
    required this.category,
    required this.condition,
    required this.numberOfBeds,
    required this.wifi,
    required this.numberOfBathrooms,
    required this.description,
    required this.location,
    required this.images,
    required this.coordinates,
  });
}
