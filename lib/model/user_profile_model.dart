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
  String? frontImage;
  String? selectedSize;
  double? selectedQuantity;
  double? discountNo;
  double? totalDiscount;
  double? totalPrice;
  Timestamp?  currentDate;

  CartModel({
    this.id,
    this.frontImage,
    this.selectedQuantity,
    this.selectedSize,
    this.totalPrice,
    this.discountNo,
    this.currentDate,
    this.totalDiscount});

  CartModel.fromMap(Map<String, dynamic> data){
    id = data["id"];
    frontImage = data["frontImage"];
    selectedQuantity = data["selectedQuantity"];
    selectedSize = data["selectedSize"];
    totalPrice = data["totalPrice"];
    discountNo = data["discountNo"];
    currentDate = data["currentDate"];
    totalDiscount = data["totalDiscount"];
  }
}