import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  final String phoneNumber;
  final String addres;
  final String description;

  PlaceModel(
    this.id,
    this.name,
    this.latLng,
    this.phoneNumber,
    this.addres,
    this.description,
  );
}

class Home {
  final String title;
  final String homeid;
  final String userid;
  final num price;
  final String location;
  final String imageUrl;
  final String numnerofBeds;
  final String wifiServices;
  final String numnerofbathroom;
  final String date;
  final String description;
  final GeoPoint coardinaties;
  Home(
      this.title,
      this.price,
      this.location,
      this.imageUrl,
      this.numnerofBeds,
      this.wifiServices,
      this.numnerofbathroom,
      this.date,
      this.description,
      this.coardinaties, this.homeid, this.userid);
}

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String content;
  final Timestamp timestamp;
  final String type;
  bool seen;

  Message(
      this.senderID,
      this.senderEmail,
      this.receiverID,
      this.content,
      this.type,
      this.seen,
      this.timestamp); // Updated constructor to include 'type'

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'content': content,
      'timestamp': timestamp,
      'type': type,
      'seen': seen,
    };
  }
}

class User {
  final String uid;
  final String email;
  final String name;

  User({
    required this.uid,
    required this.email,
    required this.name,
  });
}
