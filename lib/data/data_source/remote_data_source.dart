import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:uuid/uuid.dart';

abstract class RemoteDataSource {
  Future<void> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String? job,
    required num? salary,
    required num age,
    required String martialStatus
  });

  Future<void> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required num age,
    required String martialStatus
  });

  Future<String> saveHomesToDateBase({
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
    required GeoPoint coordinates,
  });

  Future<void> uploadImages(
    List<File> images,
    String homeId,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  RemoteDataSourceImpl(this._firestore, this._firebaseStorage);



  Future<String> saveHomesToDateBase({
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
    required GeoPoint coordinates,
  }) async {
    String uuid = Uuid().v4();

    DocumentReference docRef = await _firestore.collection('Homes').add({
      'title': title,
      'price': price,
      'area': area,
      'category': category,
      'condition': condition,
      'number_of_beds': numberOfBeds,
      'wifi': wifi,
      'number_of_bathrooms': numberOfBathrooms,
      'description': description,
      'location': location,
      'coordinates': GeoPoint(coordinates.latitude, coordinates.longitude),
      'timestamp': Timestamp.now(),
      'name': DataIntent.getUser().name,

    });

    await docRef.update({'uuid': docRef.id});

    return docRef.id;
  }

  @override
  Future<String> registerTenantToDataBase(
      {required String uuid,
        required String username,
        required String email,
        required String phoneNumber,
        required Gender gender,
        required String? job,
        required num? salary,
        required num age,
        required String martialStatus}) async {
    DocumentReference docRef = await _firestore.collection('users').add({
      'uuid': uuid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'job': job,
      'salary': salary,
      'age': age,
      'martialStatus': martialStatus,
      'userType': 'tenant',
    });
    return docRef.id;
  }


  @override
  Future<String> registerOwnerToDataBase(
      {required String uuid,
        required String username,
        required String email,
        required String phoneNumber,
        required Gender gender,
        required num age,
        required String martialStatus}) async {
    DocumentReference docRef = await _firestore.collection('users').add({
      'uuid': uuid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,

      'age': age,
      'martialStatus': martialStatus,
      'userType': 'tenant',
    });
    return docRef.id;
  }

  @override
  Future<void> uploadImages(List<File> images, String homeId) async {
    List<String> imageUrls = [];
    for (File image in images) {
      Reference ref = _firebaseStorage.ref().child(
          'home_images/$homeId-${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask = ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    await _firestore
        .collection('Homes')
        .doc(homeId)
        .update({'images': imageUrls});
  }


}
