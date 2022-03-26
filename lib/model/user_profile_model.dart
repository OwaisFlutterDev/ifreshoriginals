import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  UserProfileModel({
    this.uid,
    this.username,
    this.image,
    this.phoneNumber,
    this.email,
    this.address,
    this.cart
  });

  String? uid;
  String? username;
  String? email;
  String? image;
  String? phoneNumber;
  String? address;
  List? cart;

  UserProfileModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc["uid"];
    username = doc["username"];
    email = doc["email"];
    image = doc["image"];
    phoneNumber = doc["phoneNumber"];
    address = doc["address"];
    cart = doc["cart"];
  }
}