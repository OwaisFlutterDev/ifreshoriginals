import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import '../model/shipping_model.dart';

class ShippingController extends GetxController {

  bool isCheckedOne = false;
  bool isCheckedTwo = false;
  bool isCheckedThree = false;

  List<SizeModel> selectSizeList = [
    SizeModel(size: "S"),
    SizeModel(size: "M"),
    SizeModel(size: "L"),
    SizeModel(size: "XL"),
    SizeModel(size: "2XL"),
  ];

  // --=-=-=-============= Calculation ==============-=-=-=-=--
  int? selectedSizedIndex = 0 ;
  String? selectedSize = "S" ;

  int? selectedQuantityIndex = 0;
  num? selectedQuantity = 1;
  num? discount = 0;

  num? subTotal = 0;
  num? discountPer = 0;
  num? totalPrice = 0;

  calculationFun() {
    HomeController homeController = Get.find<HomeController>();

    subTotal = homeController.newDesignPrice! * selectedQuantity!;
    discountPer = subTotal! / 100 * discount! ;
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