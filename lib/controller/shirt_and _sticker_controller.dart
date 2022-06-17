import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/model/create_new_design_models.dart';
import 'package:ifreshoriginals_userapp/model/price_model.dart';
import 'package:ifreshoriginals_userapp/model/shirt_image_model.dart';

class ShirtAndStickerController extends GetxController{

  RxList<StickerDataModel> stickerList = RxList<StickerDataModel>([]);
  // RxList<ShirtImageModel> shirtImageList = RxList<ShirtImageModel>([]);

  CollectionReference collectionReferenceOfPrice = FirebaseFirestore.instance.collection("shirts");

  @override
  void onInit() {
    super.onInit();

    // shirtImageList.bindStream(getShirtImagesData());

  }

  //           ===============================================================================
  // -------------- ==========    Get featured design of current user data from Firestore    ========== --------------
  //           ===============================================================================

  Stream<List<ShirtImageModel>> getShirtImagesData() =>
      collectionReferenceOfPrice.snapshots().map((query) =>
          query.docs.map((item) =>
              ShirtImageModel.fromDocumentSnapshot(item)).toList());

  // String? id = "WgnBHn01s1w09e0SGB4p";
  // int? textPrice;
  // int? stickerPrice;
  // int? imageOnShirtPrice;
  // int? deliveryOnDemandPrice;
  // int? deliveryExpeditePrice;
  // int? deliveryStandardPrice;
  //
  // Future getAllPriceData() async{
  //
  //   var collection = FirebaseFirestore.instance.collection('price');
  //   var querySnapshot = await collection.where('id', isEqualTo: id).get();
  //
  //   for (var queryDocumentSnapshot in querySnapshot.docs) {
  //     Map<String, dynamic> data = queryDocumentSnapshot.data();
  //     textPrice = data["textPrice"];
  //     stickerPrice = data["stickerPrice"];
  //     imageOnShirtPrice = data["imageOnShirtPrice"];
  //     deliveryOnDemandPrice = data["deliveryOnDemandPrice"];
  //     deliveryExpeditePrice = data["deliveryExpeditePrice"];
  //     deliveryStandardPrice = data["deliveryStandardPrice"];
  //     update();
  //
  //   }
  // }
  //
}