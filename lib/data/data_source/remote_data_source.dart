import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/data/network/app_api.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

abstract class RemoteDataSource {
  Future<void> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String job,
    required int salary,
    required int age,
    required String martialStatus,
  });

  Future<void> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required int age,
  });

  Future<void> login({
    required String email,
    required String password,
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

  Future<Stream<List<Map<String, dynamic>>>> getAllHomes();

  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pickup, LatLng destination);

  Future<void> addToFavorites({
    required String userId,
    required String homeId,
  });

  Future<void> removeFromFavorites({
    required String userId,
    required String homeId,
  });

  Future<Stream<List<dynamic>>> getAllFavorites({
    required String userId,
  });

  Future<Map<String, dynamic>> getHomeById({
    required String homeId,
  });

  Future<Map<String, dynamic>?> getUserData({
    required String email,
  });

  Future<void> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  });

  Future<void> changeAccountInfo({
    required String userId,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  });

  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
  });

  Future<void> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(
      this._firestore, this._firebaseStorage, this._appServiceClient);

  @override
  Future<void> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String job,
    required int salary,
    required int age,
    required String martialStatus,
  }) async {
    await _firestore.collection('users').doc(uuid).set({
      'id': uuid,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender.name,
      'age': age,
      'current_job': job,
      'current_salary': salary,
      'martial_status': martialStatus,
      'user_type': 'tenant',
      'favorites': [],
    });
  }

  @override
  Future<void> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required int age,
  }) async {
    await _firestore.collection('users').doc(uuid).set({
      'id': uuid,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender.name,
      'age': age,
      'user_type': 'owner',
      'favorites': [],
    });
  }

  @override
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
      'owner_id': DataIntent.getUser().uid,
      'rating': 3.5,
      'numberOfRatings': 1,
      'name': name,
    });

    await docRef.update({'uuid': docRef.id});

    return docRef.id;
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    //todo create login logic
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

  @override
  Future<Stream<List<Map<String, dynamic>>>> getAllHomes() async {
    return _firestore.collection('Homes').snapshots().map(
          (homes) => homes.docs
              .map(
                (home) => home.data(),
              )
              .toList(),
        );
  }

  @override
  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pointA, LatLng pointB) async {
    return await _appServiceClient.calculateTwoPoints(pointA, pointB);
  }

  @override
  Future<void> addToFavorites({
    required String userId,
    required String homeId,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayUnion([homeId]),
    });
  }

  @override
  Future<void> removeFromFavorites({
    required String userId,
    required String homeId,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayRemove([homeId]),
    });
  }

  @override
  Future<Stream<List<dynamic>>> getAllFavorites({
    required String userId,
  }) async {
    return _firestore.collection('users').doc(userId).snapshots().map(
          (user) => user.data()!['favorites'],
        );
  }

  @override
  Future<Map<String, dynamic>> getHomeById({
    required String homeId,
  }) async {
    return await _firestore
        .collection('Homes')
        .doc(homeId)
        .get()
        .then((value) => value.data()!);
  }

  @override
  Future<Map<String, dynamic>?> getUserData({
    required String email,
  }) async {
    Map<String, dynamic>? user;
    await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (value) {
        user = value.docs.firstOrNull?.data();
      },
    );
    return user;
  }

  @override
  Future<void> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  }) async {
    await _firestore.collection('Homes').doc(homeId).collection('reports').add(
      {
        'userId': userId,
        'content': report,
        'submitted_at': submittedAt,
      },
    );
  }

  @override
  Future<void> changeAccountInfo({
    required String userId,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  }) async {
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    if (pictureChanged) {
      String picturePath = '$userId-picture';
      late TaskSnapshot imageUrl;
      await docRef.get().then(
        (value) async {
          imageUrl = await _firebaseStorage
              .ref('user_images')
              .child(picturePath)
              .putFile(
                picture!,
                SettableMetadata(contentType: 'image/jpeg'),
              );
        },
      );
      await docRef.update({
        'image_path': await imageUrl.ref.getDownloadURL(),
      });
    }
    await docRef.update({
      'email': email,
      'phone_number': phoneNumber,
    });
  }

  @override
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
  }) async {
    bool emailUsed = false;
    await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          emailUsed = true;
        }
      },
    );

    if (emailUsed) {
      return RegisteredBeforeError.emailUsed;
    } else {
      return null;
    }
  }

  @override
  Future<void> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('payment_cards')
        .doc(cardNumber)
        .set(
      {
        'card_name': cardName,
        'card_number': cardNumber,
        'card_expiration_date': cardExpirationDate,
      },
    );
  }
}
