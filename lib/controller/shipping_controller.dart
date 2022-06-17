import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import '../model/shipping_model.dart';

class ShippingController extends GetxController {

  @override
  void onInit(){
    super.onInit();
    getAllPriceData();
  }

  bool deliveryStandardBool = false;
  bool deliveryExpediteBool = false;
  bool deliveryOnDemandBool = false;


  List<SizeModel> selectSizeList = [
    SizeModel(size: "S"),
    SizeModel(size: "M"),
    SizeModel(size: "L"),
    SizeModel(size: "XL"),
    SizeModel(size: "2XL"),
  ];

  String? id = "WgnBHn01s1w09e0SGB4p";

  int? deliveryStandardPrice;
  int? deliveryExpeditePrice;
  int? deliveryOnDemandPrice;



  Future getAllPriceData() async{

    var collection = FirebaseFirestore.instance.collection('price');
    var querySnapshot = await collection.where('id', isEqualTo: id).get();

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      deliveryOnDemandPrice = data["deliveryOnDemandPrice"];
      deliveryExpeditePrice = data["deliveryExpeditePrice"];
      deliveryStandardPrice = data["deliveryStandardPrice"];
      update();

    }
  }

  // --=-=-=-============= Calculation ==============-=-=-=-=--
  int? selectedSizedIndex = 0 ;
  String? selectedSize = "S" ;

  int? selectedQuantityIndex = 0;
  int? selectedQuantity = 1;
  int? discount = 0;

  int? subTotal = 0;
  int? discountPer = 0;
  int? totalPrice = 0;

  calculationFun() {
    HomeController homeController = Get.find<HomeController>();

    subTotal = homeController.newDesignPrice! * selectedQuantity!;
    discountPer = (subTotal! / 100 * discount!).toInt();
    totalPrice = subTotal! - discountPer!;
    print("Total Price $totalPrice");
    update();
  }

  List<QuantityModel> selectQuantityList = [
    QuantityModel(quantity: 1,discount: 0),
    QuantityModel(quantity: 2,discount: 0),
    QuantityModel(quantity: 3,discount: 4),
    QuantityModel(quantity: 4,discount: 4),
    QuantityModel(quantity: 5,discount: 4),
    QuantityModel(quantity: 10,discount: 8),
    QuantityModel(quantity: 15,discount: 12),
    QuantityModel(quantity: 20,discount: 16),
    QuantityModel(quantity: 25,discount: 20),
  ];
}