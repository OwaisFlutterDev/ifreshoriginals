import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/cart_controller.dart';
import 'package:ifreshoriginals_userapp/model/order_model.dart';
import 'package:ifreshoriginals_userapp/model/user_profile_model.dart';

class OrderController extends GetxController{

  final GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();

  RxList<OrderModel> orderHistoryList = RxList<OrderModel>([]);
  RxList<OrderModel> allOrderHistoryList = RxList<OrderModel>([]);
  //   ----- ========== Text Editing Controller ========== -----
  late  TextEditingController emailController,  usernameController, phoneController,
      addressController, cityController, countryController, stateController, zipCodeController;

  @override
  void onInit(){
    super.onInit();

    orderHistoryList.bindStream(getOrderData());
    allOrderHistoryList.bindStream(getAllOrderData());

    emailController = TextEditingController();
    usernameController = TextEditingController();

    phoneController = TextEditingController();
    addressController = TextEditingController();

    cityController = TextEditingController();
    countryController = TextEditingController();

    stateController = TextEditingController();
    zipCodeController = TextEditingController();

  }

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("OrderDetails");
  final currentUser = FirebaseAuth.instance.currentUser;

  Stream<List<OrderModel>> getOrderData() =>
      collectionReference.where("uId", isEqualTo: currentUser!.uid.toString()).orderBy("currentDate", descending: true).limit(3).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              OrderModel.fromDocumentSnapshot(item)).toList());


  Stream<List<OrderModel>> getAllOrderData() =>
      collectionReference.where("uId", isEqualTo: currentUser!.uid.toString()).orderBy("currentDate", descending: true).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              OrderModel.fromDocumentSnapshot(item)).toList());

  // ------ =-=-  adding order details -=-=-= ------
  Future addOrderDetails(int totalAmount, int deliveryCharge) async {

    try{

      final CartController cartController = Get.put(CartController());
      List _productItemList = [];

      final currentUser = FirebaseAuth.instance.currentUser;


      for (CartModel productItemList in cartController.cartList.value.cart!) {
          print(productItemList.currentDate);
          _productItemList.add({
            "id": productItemList.id,
            "designType": productItemList.designType,
            "frontImage": productItemList.frontImage,
            "backImage": productItemList.backImage,
            "selectedSize": productItemList.selectedSize,
            "perShirtPrice": productItemList.perShirtPrice,
            "selectedQuantity":  productItemList.selectedQuantity,
            "totalDiscount":  productItemList.totalDiscount,
            "totalPrice": productItemList.totalPrice,
            "subTotal": productItemList.subTotal,
            "currentDate": productItemList.currentDate,
          });
        }

      final addOrder = FirebaseFirestore.instance.collection("OrderDetails").doc();
      await addOrder.set({

        "id": addOrder.id,
        "uId": currentUser!.uid ,
        "email": emailController.text,
        "username": usernameController.text,
        "phoneNo": phoneController.text,
        "address": addressController.text,
        "city": cityController.text,
        "country": countryController.text,
        "state": stateController.text,
        "zipCode": zipCodeController.text,
        "payedAmount": totalAmount.toString(),
        "currentDate": DateTime.now(),
        "status":  false,
        "deliveryTime": deliveryCharge == 14 ? "Est Delivery in 8-10 Business Days" : deliveryCharge == 17 ?
                         "Est Delivery in 4-8 Business Days" : "Est Delivery in 3-6 Business Days",
        "deliveryCharge": deliveryCharge,
        "productList": _productItemList

      }).then((_) => {
        print("Order Data is Added"),
      }).catchError((onError) => print(onError.toString()));

    } catch (e){
      print(e);
    }
  }

}