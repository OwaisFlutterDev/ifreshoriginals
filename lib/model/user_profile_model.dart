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
  List<CartModel>? cart;

  UserProfileModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc["uid"];
    username = doc["username"];
    email = doc["email"];
    image = doc["image"];
    phoneNumber = doc["phoneNumber"];
    address = doc["address"];
    cart = _cartItems(doc["cart"] ?? []);
  }
  // ------= -=-== convert text of first image ==-=- =------
  List<CartModel> _cartItems(List cartItemFromDB){
    List<CartModel> _result = [];
    if(cartItemFromDB.isNotEmpty){
      for (var element in cartItemFromDB) {
        _result.add(CartModel.fromMap(element));
      }
    }
    return _result;
  }

}

class CartModel {
  String? id;
  String? designType;
  String? frontImage;
  String? backImage;
  String? selectedSize;
  num? perShirtPrice;
  num? selectedQuantity;
  num? discountNo;
  num? totalDiscount;
  num? totalPrice;
  num? subTotal;
  int? selectedSizedIndex;
  Timestamp?  currentDate;

  CartModel({
    this.id,
    this.backImage,
    this.designType,
    this.frontImage,
    this.selectedQuantity,
    this.selectedSize,
    this.totalPrice,
    this.perShirtPrice,
    this.discountNo,
    this.currentDate,
    this.subTotal,
    this.selectedSizedIndex,
    this.totalDiscount});

  CartModel.fromMap(Map<String, dynamic> data){
    id = data["id"];
    designType = data["designType"];
    frontImage = data["frontImage"];
    backImage = data["backImage"];
    selectedQuantity = data["selectedQuantity"];
    perShirtPrice = data["perShirtPrice"];
    selectedSize = data["selectedSize"];
    subTotal = data["subTotal"];
    totalPrice = data["totalPrice"];
    discountNo = data["discountNo"];
    currentDate = data["currentDate"];
    totalDiscount = data["totalDiscount"];
    selectedSizedIndex = data["selectedSizedIndex"];
  }

  Map toJson() => {
    "id": id,
    "designType": designType,
    "frontImage": frontImage,
    "backImage": backImage,
    "selectedQuantity": selectedQuantity,
    "perShirtPrice": perShirtPrice,
    "selectedSize": selectedSize,
    "subTotal": subTotal,
    "totalPrice": totalPrice,
    "discountNo": discountNo,
    "currentDate": currentDate,
    "totalDiscount": totalDiscount,
    "selectedSizedIndex": selectedSizedIndex,
  };


}