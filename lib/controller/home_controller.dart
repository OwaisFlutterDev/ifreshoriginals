import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/cart_controller.dart';
import '../model/create_new_design_models.dart';


class HomeController extends GetxController {

  final CartController cartController = Get.put(CartController());

  // ------------------------------------------------------------------------------
  // ---=-=-=========== -=-=        create new design price =-=- ==========-=-=----
  //-------------------------------------------------------------------------------
  num? newDesignPrice = 0;
  num? shirtPrice = 0;

  // num? newDesignPriceForOD = 0;
  // num? shirtPriceForOD = 0;


  // -====-==-=====------------------------------------------------==-===-============
  RxList<NewShirtDesignModel> savedDesignDataList = RxList<NewShirtDesignModel>([]);
  RxList<NewShirtDesignModel> savedDesignAllDataList = RxList<NewShirtDesignModel>([]);

  RxList<NewShirtDesignModel> allDesignLimitedDataList = RxList<NewShirtDesignModel>([]);
  RxList<NewShirtDesignModel> allDesignDataList = RxList<NewShirtDesignModel>([]);
  // 127.0.0.1:59915
  RxList<NewShirtDesignModel> featuredDesignLimitedDataList = RxList<NewShirtDesignModel>([]);
  RxList<NewShirtDesignModel> featuredDesignDataList = RxList<NewShirtDesignModel>([]);

  RxList<NewShirtDesignModel> popularDesignLimitedDataList = RxList<NewShirtDesignModel>([]);
  RxList<NewShirtDesignModel> popularDesignDataList = RxList<NewShirtDesignModel>([]);


  CollectionReference collectionReference = FirebaseFirestore.instance.collection("NewShirtDesign");

  @override
  void onInit() {
    super.onInit();

    // InAppPayments.setSquareApplicationId('sandbox-sq0idb-DmyyChN1jRRS7sq8M3e_XQ');

    savedDesignDataList.bindStream(getSavedDesignData());
    savedDesignAllDataList.bindStream(getAllSavedDesignData());

    allDesignLimitedDataList.bindStream(getAllDesignLimitedData());
    allDesignDataList.bindStream(getAllDesignData());

    featuredDesignLimitedDataList.bindStream(getFeaturedDesignLimitedData());
    featuredDesignDataList.bindStream(getFeaturedDesignData());

    popularDesignLimitedDataList.bindStream(getPopularDesignLimitedData());
    popularDesignDataList.bindStream(getPopularDesignData());

  }

  // ----------------------------=== ================================================== ===------------------------
  // ----------------------------===         Create New Design Data And Functions       ===------------------------
  // ----------------------------=== ================================================== ===------------------------
  String? selectedFrontImage;
  String? selectedBackImage;
  String? selectedDesignType;


  String? selectedFrontImageOfOpenedDesign;
  String? selectedBackImageOfOpenedDesign;
  String? selectedShirtNameOfOpenedDesign;
  String? selectedShirtTypeOfOpenedDesign;
  int? selectedFirstImageColorOfOpenedDesign;
  int? selectedSecondImageColorOfOpenedDesign;
  int? popularityCountInt;

  List<ShirtModel> createNewDesignList = [
    ShirtModel(
        frontImage: "assets/t_shirt.png",
        backImage: "assets/t_shirt.png",
        title: "Classic Tee Unisex",
        shirtPrice: 15
    ),
    ShirtModel(
        frontImage: "assets/Crewneck.png",
        backImage: "assets/Crewneck.png",
        title: "Crewneck",
        shirtPrice: 25
    ),
    ShirtModel(
        frontImage: "assets/Long-Sleeve.png",
        backImage: "assets/Long-Sleeve.png",
        title: "Adult Long-Sleeve",
        shirtPrice: 10.5
    ),
    ShirtModel(
        frontImage: "assets/Women's-Tee.png",
        backImage: "assets/Women's-Tee.png",
        title: "T-Shirt For Women",
        shirtPrice: 25
    ),
  ];

  //           ===============================================================================
  // -------------- ==========    Get Saved design of current user data from Firestore    ========== --------------
  //           ===============================================================================
  User? user = FirebaseAuth.instance.currentUser;

  Stream<List<NewShirtDesignModel>> getSavedDesignData() =>
      collectionReference.where("userId", isEqualTo: user!.uid.toString())
          .orderBy("currentDateTime", descending: true).limit(5).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());


  Stream<List<NewShirtDesignModel>> getAllSavedDesignData() =>
      collectionReference.where("userId", isEqualTo: user!.uid.toString())
          .orderBy("currentDateTime", descending: true).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());

  //           ===============================================================================
  // -------------- ==========    Get All design of current user data from Firestore    ========== --------------
  //           ===============================================================================

  Stream<List<NewShirtDesignModel>> getAllDesignLimitedData() =>
      collectionReference.limit(5).snapshots().map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());


  Stream<List<NewShirtDesignModel>> getAllDesignData() =>
      collectionReference.snapshots()
          .map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());


  //           ===============================================================================
  // -------------- ==========    Get featured design of current user data from Firestore    ========== --------------
  //           ===============================================================================

  Stream<List<NewShirtDesignModel>> getFeaturedDesignLimitedData() =>
      collectionReference.orderBy("currentDateTime", descending: false,).limit(5).snapshots().map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());


  Stream<List<NewShirtDesignModel>> getFeaturedDesignData() =>
      collectionReference.orderBy("currentDateTime", descending: false,).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());


  //           ===============================================================================
  // -------------- ==========    Get Popular design of current user data from Firestore    ========== --------------
  //           ===============================================================================

  Stream<List<NewShirtDesignModel>> getPopularDesignLimitedData() =>
      collectionReference.orderBy("popularityCount", descending: true,).limit(5).snapshots().map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());

  Stream<List<NewShirtDesignModel>> getPopularDesignData() =>
      collectionReference.orderBy("popularityCount", descending: true,).snapshots()
          .map((query) =>
          query.docs.map((item) =>
              NewShirtDesignModel.fromDocumentSnapshot(item)).toList());
}