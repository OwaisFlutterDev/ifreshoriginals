import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  UserProfileModel({
    this.uid,
    this.username,
    this.image,
    this.phoneNumber,
    this.email,
    this.address
  });

  String? uid;
  String? username;
  String? email;
  String? image;
  String? phoneNumber;
  String? address;

  UserProfileModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc["uid"];
    username = doc["username"];
    email = doc["email"];
    image = doc["image"];
    phoneNumber = doc["phoneNumber"];
    address = doc["address"];
  }
}