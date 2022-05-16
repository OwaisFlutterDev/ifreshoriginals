import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? id;
  String?  email;
  String? username;
  String? phoneNo;
  String? address;
  String? city;
  String? country;
  String? state;
  int? zipCode;
  String? payedAmount;
  String? deliveryTime;
  int? deliveryCharge;
  Timestamp? currentDate;
  bool? status;
  List<ProductModel>? productList;


  OrderModel({this.email, this.username,this.phoneNo, this.address,this.currentDate,
              this.city,this.country,this.state,this.zipCode,this.productList,this.status,
              this.id,this.payedAmount,this.deliveryCharge,this.deliveryTime
  });

  OrderModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    username = doc["username"];
    email = doc["email"];
    phoneNo = doc["phoneNo"];
    address = doc["address"];
    city = doc["city"];
    country = doc["country"];
    state = doc["state"];
    zipCode = doc["zipCode"];
    payedAmount = doc["payedAmount"];
    deliveryCharge = doc["deliveryCharge"];
    deliveryTime = doc["deliveryTime"];
    currentDate = doc["currentDate"];
    status = doc["status"];
    productList = _productItems(doc["productList"] ?? []);
  }
  // ------= -=-== convert text of first image ==-=- =------
  List<ProductModel> _productItems(List cartItemFromDB){
    List<ProductModel> _result = [];
    if(cartItemFromDB.isNotEmpty){
      for (var element in cartItemFromDB) {
        _result.add(ProductModel.fromMap(element));
      }
    }
    return _result;
  }


}

class ProductModel {
  String? id;
  String? designType;
  String? frontImage;
  String? backImage;
  String? selectedSize;
  double? perShirtPrice;
  double? selectedQuantity;
  double? totalDiscount;
  double? totalPrice;
  double? subTotal;
  Timestamp?  currentDate;

  ProductModel({
    this.id,
    this.backImage,
    this.designType,
    this.frontImage,
    this.selectedQuantity,
    this.selectedSize,
    this.totalPrice,
    this.perShirtPrice,
    this.currentDate,
    this.subTotal,
    this.totalDiscount});

  ProductModel.fromMap(Map<String, dynamic> data){
    id = data["id"];
    designType = data["designType"];
    frontImage = data["frontImage"];
    backImage = data["backImage"];
    selectedQuantity = data["selectedQuantity"];
    perShirtPrice = data["perShirtPrice"];
    selectedSize = data["selectedSize"];
    subTotal = data["subTotal"];
    totalPrice = data["totalPrice"];
    currentDate = data["currentDate"];
    totalDiscount = data["totalDiscount"];
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
    "currentDate": currentDate,
    "totalDiscount": totalDiscount,
  };

}