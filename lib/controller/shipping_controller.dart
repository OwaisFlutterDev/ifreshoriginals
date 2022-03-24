import 'package:get/get.dart';

import '../model/shipping_model.dart';

class ShippingController extends GetxController {

  bool isCheckedOne = false;
  bool isCheckedTwo = false;
  bool isCheckedThree = false;

  int? selectedSizedIndex ;
  String? selectedSize ;

  List<SizeModel> selectSizeList = [
    SizeModel(size: "S"),
    SizeModel(size: "M"),
    SizeModel(size: "L"),
    SizeModel(size: "XL"),
    SizeModel(size: "2XL"),
  ];

  int? selectedQuantityIndex ;
  int selectedQuantity = 0 ;

  List<QuantityModel> selectQuantityList = [
    QuantityModel(quantity: 1),
    QuantityModel(quantity: 2),
    QuantityModel(quantity: 3),
    QuantityModel(quantity: 4),
    QuantityModel(quantity: 5),
    QuantityModel(quantity: 10),
    QuantityModel(quantity: 15),
    QuantityModel(quantity: 20),
    QuantityModel(quantity: 25),
  ];

}