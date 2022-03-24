import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/cart_screen.dart';
import '../../constant/constants.dart';
import 'common_widgets.dart';
import 'package:get/get.dart';


// ---- =======  Drawer Button Widget ====== ------
Widget drawerButtonWidget({void Function()? onTap}) {
  return InkWell(
   onTap: onTap,
    child: Row(
      children: [
        SizedBox(width: 40.w,),
        Container(
          height: 90.h,
          width: 90.w,
          color: Colors.transparent,
          child: Image(image: AssetImage("assets/Top Bar.png"),
            color: blackColor, fit: BoxFit.scaleDown,),
        ),
      ],
    ),
  );
}

// ---- =======  Cart Button Widget  ====== ------
InkWell cartButtonWidget() {
  return InkWell(
    onTap: () => Get.to(() => CartScreen()),
    child: Container(
      height: 90.h,
      width: 90.w,
      color: Colors.transparent,
      child: Image(image: AssetImage("assets/Asset 23.png"),
        color: blackColor, fit: BoxFit.scaleDown,),
    ),
  );
}

// ---- =======  create New Design Widget  ====== ------
Widget createNewDesignWidget({void Function()? onTap, String? image,String? name}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: 300.h,
          width: 300.w,
          decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                offset: Offset(0, 4,),
              )
            ],
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 52.h),
            child: Container(
              height: 240.h,
              width: 240.w,
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                  // image: DecorationImage(image: AssetImage(image!),fit: BoxFit.scaleDown,),
              ),
              child: Image(image: AssetImage(image!),fit: BoxFit.scaleDown,)),
            ),
          ),
        SizedBox(height: 28.h,),
        Wrap(
          children: [
            smallText(title: name,),
          ],
        )
      ],
    ),
  );
}

// ---- =======  Saved And Design History Widget  ====== ------
Widget savedAndDesignHistoryWidget({void Function()? onTap, String? image,String? name}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: 270.h,
          width: 300.w,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(30.r),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 5,),
              )
            ],
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.h),
            child: Container(
              height: 240.h,
              width: 250.w,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(30.r),
                  image: DecorationImage(image: NetworkImage(image!),fit: BoxFit.scaleDown,)
              ),
            ),
          ),
        ),
        SizedBox(height: 28.h,),
        smallText(title: name,)
      ],
    ),
  );
}

// ---- =======  Section Title Widget  ====== ------
Widget sectionTitleWidget({void Function()? onTap, String? title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      headerThree(title: title,color: blackColor,fontWeight: FontWeight.w500),
      InkWell(
        onTap: onTap,
          child: smallText(title: "See all",color: redColor,))
    ],);
}