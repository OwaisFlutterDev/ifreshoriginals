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
  int discount = 0;

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