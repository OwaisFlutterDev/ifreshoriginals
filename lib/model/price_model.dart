import 'package:cloud_firestore/cloud_firestore.dart';

class PriceModel {
  String? id;
  int? textPrice;
  int? stickerPrice;
  int? imageOnShirtPrice;
  int? deliveryOnDemandPrice;
  int? deliveryExpeditePrice;
  int? deliveryStandardPrice;

  PriceModel({
    this.id,
    this.textPrice,
    this.stickerPrice,
    this.imageOnShirtPrice,
    this.deliveryOnDemandPrice,
    this.deliveryExpeditePrice,
    this.deliveryStandardPrice
  });

  PriceModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    textPrice = doc["textPrice"];
    stickerPrice = doc["stickerPrice"];
    imageOnShirtPrice = doc["imageOnShirtPrice"];
    deliveryOnDemandPrice = doc["deliveryOnDemandPrice"];
    deliveryExpeditePrice = doc["deliveryExpeditePrice"];
    deliveryStandardPrice = doc["deliveryStandardPrice"];
  }

}