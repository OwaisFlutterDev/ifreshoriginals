import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';

Widget imageWidget({double? height, double? width, String? image }) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(image: AssetImage(image!),fit: BoxFit.scaleDown)),
  );
}

// -- ====  app bar for user auth ==== ---
AppBar appbarForUserAuth({String? title }) {
  return AppBar(
    title: commonText(
        title: title,textStyle:
    TextStyle(color: Colors.black,fontSize: 50.sp,fontWeight: FontWeight.w500)
    ),
    centerTitle: true,
    backgroundColor: bgColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(CupertinoIcons.back,color: blackColor,size: 75.r)),
  );
}