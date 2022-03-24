import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/screens/shipping_screens/shipping_method_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingAddressScreen extends StatelessWidget{
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
        title: "Shipping Address",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h,),
                headerThree(title: "Please add shipping address details",
                    color: blackColor, fontWeight: FontWeight.w600),
                SizedBox(height: 70.h,),
                Form(
                  child: Column(
                    children: [
                      commonTextFormField(
                        hintText: "Email",
                        prefixIcon: (CupertinoIcons.mail),
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "Username",
                        prefixIcon: (CupertinoIcons.person),
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "Phone Number",
                        prefixIcon: (CupertinoIcons.phone),
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "Address",
                        prefixIcon: (CupertinoIcons.location),
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "City",
                        prefixIcon: (CupertinoIcons.building_2_fill),
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormFieldForImage(
                        hintText: "Country",
                        prefixIcon: "assets/Asset 71.png",
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormFieldForImage(
                        hintText: "State",
                        prefixIcon: "assets/Asset 72.png",
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormFieldForImage(
                        hintText: "Zip Code",
                        prefixIcon: "assets/Asset 73.png",
                      ),
                      SizedBox(height: 90.h,),
                      commonButton(
                        onTap: (){
                          Get.to(() => ShippingMethodScreen());
                        },
                        buttonWidth: 1.sw,
                        buttonHeight: 130.h,
                        buttonColor: redColor,
                        buttonName: "Proceed",
                        textStyle: TextStyle(color: whiteColor,fontWeight: FontWeight.w600)
                      ),
                      SizedBox(height: 40.h,),

                  ],),
                )

              ],),
          ),),),
    );
  }
}