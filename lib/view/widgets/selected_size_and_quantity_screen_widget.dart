import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container discountWidget({String? discount, String? quantity,
  BoxDecoration? boxDecoration , Color? textColorForQuantity, Color? textColorForDiscount}) {
  return Container(
      height: 200.h,
      width: 140.w,
      decoration: boxDecoration,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          smallText(
              color:  textColorForQuantity,
              fontWeight: FontWeight.w500,
              title: quantity
          ),
          SizedBox(height: 30.h,),
          largeText(
              color:  textColorForDiscount,
              title:"$discount%",
              fontWeight: FontWeight.w600
          ),
        ],
      )
  );
}
