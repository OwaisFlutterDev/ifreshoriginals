import 'package:cloud_firestore/cloud_firestore.dart';

class ShirtImageModel {
  String? id;
  String? frontImage;
  String? backImage;
  String? shirtName;
  int? shirtPrice;

  ShirtImageModel({
    this.id,
    this.frontImage,
    this.shirtName,
    this.backImage,
    this.shirtPrice
  });

  ShirtImageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    frontImage = doc["frontImage"];
    shirtName = doc["shirtName"];
    backImage = doc["backImage"];
    shirtPrice = doc["shirtPrice"];
  }

}