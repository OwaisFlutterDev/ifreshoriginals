import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/cart_controller.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import 'package:ifreshoriginals_userapp/model/order_model.dart';
import 'package:ifreshoriginals_userapp/model/user_profile_model.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController{

  final GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();

  RxList<OrderModel> orderHistoryList = RxList<OrderModel>([]);
  RxList<OrderModel> allOrderHistoryList = RxList<OrderModel>([]);
  //   ----- ========== Text Editing Controller ========== -----
  late  TextEditingController emailController,  firstNameController, lastNameController, phoneController,
      addressController, cityController, countryController, stateController, zipCodeController;

  @override
  void onInit(){
    super.onInit();

    orderHistoryList.bindStream(getOrderData());
    allOrderHistoryList.bindStream(getAllOrderData());

    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

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
      final ShippingController shippingController = Get.put(ShippingController());

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
      String username = "${firstNameController.text} ${lastNameController.text}";
      final addOrder = FirebaseFirestore.instance.collection("OrderDetails").doc();
      await addOrder.set({
        "id": addOrder.id,
        "uId": currentUser!.uid ,
        "email": emailController.text,
        "username": username,
        "phoneNo": phoneController.text,
        "address": addressController.text,
        "city": cityController.text,
        "country": countryController.text,
        "state": stateController.text,
        "zipCode": zipCodeController.text,
        "payedAmount": totalAmount,
        "currentDate": DateTime.now(),
        "todayDate": DateFormat("dd-MM-yyyy").format(DateTime.now()),
        "status":  false,
        // ignore: unrelated_type_equality_checks
        "deliveryTime": shippingController.deliveryStandardBool == true ? "Est Delivery in 8-10 Business Days" : shippingController.deliveryExpediteBool == true?
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