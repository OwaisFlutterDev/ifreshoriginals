import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/bottom_navigation_bar_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';

class OrderPlacedConformationScreen extends StatelessWidget{
  const OrderPlacedConformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
        title: "Order",
        leadingWidget: InkWell(
          onTap: () => Get.back(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.w,),
              Icon(CupertinoIcons.back,color: blackColor,size: 90.r),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                 SizedBox(height: 70.h,),
                 Center(
                   child: imageWidget(
                     width: 400.w,
                     height: 500.h,
                     image: "assets/Asset 11.png"
                   ),
                 ),
                SizedBox(height: 60.h,),
                headerTwo(
                    title: "Order Placed Successfully!",fontWeight: FontWeight.w700),
                SizedBox(height: 50.h,),
                smallText(
                  textAlign: TextAlign.center,
                  title: "Your oder have been successfully placed. Your order will be delivered as soon as possible",
                ),
                SizedBox(height: 170.h,),
                commonButton(
                    onTap: (){
                      Get.offAll(() => BottomNavigationBarScreen());
                    },
                    buttonWidth: 1.sw,

                    buttonColor: redColor,
                    buttonName: "Done",
                  textColor: whiteColor,
                ),
              ],),
          ),),),
    );
  }
}