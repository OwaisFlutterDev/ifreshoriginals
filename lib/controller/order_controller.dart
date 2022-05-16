import 'package:cloud_firestore/cloud_firestore.dart';
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
  late QuerySnapshot snapshotOfOrderHistory;

  Future searchProduct(String productName) async {

    try{
      await FirebaseFirestore.instance.collection('OrderDetails').where('productName', isEqualTo: productName).get().then((value) {
        snapshotOfOrderHistory = value;
      });

      print("length of Order ${snapshotOfOrderHistory.docs.length}");
      update();

    }
    catch(e)
    {
      print(e);
    }
  }


  CollectionReference collectionReference = FirebaseFirestore.instance.collection("OderHistory");

  Stream<List<OrderModel>> getOrderData() =>
      collectionReference.orderBy("currentDate", descending: true).limit(5).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              OrderModel.fromDocumentSnapshot(item)).toList());


  Stream<List<OrderModel>> getAllOrderData() =>
      collectionReference.orderBy("currentDate", descending: true).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              OrderModel.fromDocumentSnapshot(item)).toList());

  // ------ =-=-  adding order details -=-=-= ------
  Future addOrderDetails(int totalAmount, int deliveryCharge) async {

    try{

      final CartController cartController = Get.put(CartController());
      List _productItemList = [];


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