import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constants.dart';
import '../../../controller/cart_controller.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/common_widgets.dart';
import '../shipping_screens/shapping_address_screen.dart';
import 'drawer_screens/privacy_policy.dart';
import 'drawer_screens/terms_and_conditions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-------------------------------------------------
      //     ------ ========== appbar ======== ------
      //-------------------------------------------------
      appBar: appBar(
        title: "Cart",
        leadingWidget: InkWell(
          onTap: () => Get.back(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Icon(CupertinoIcons.back, color: blackColor, size: 90.r),
            ],
          ),
        ),
      ),
      backgroundColor: bgColor,
      //-------------------------------------------------
      //     ------ ========== body ======== ------
      //-------------------------------------------------
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              headerThree(
                  title: "Item Details",
                  color: blackColor,
                  fontWeight: FontWeight.w600),
              SizedBox(
                height: 60.h,
              ),

              //-------------------------------------------------
              //     ------ ========== cart item  ======== ------
              //-------------------------------------------------
              cartItemWidget(
                  image: "https://tinyurl.com/ybp5syc4",
                  editItem: () {},
                  deleteItem: () {},
                  size: "XL",
                  price: "14.00",
                  quantity: "2",
                  category: "Animal Kindgom"),

              //-------------------------------------------------
              //     ------ ========== cart item  ======== ------
              //-------------------------------------------------
              SizedBox(
                height: 170.h,
              ),
              headerThree(
                  title: "Price Details",
                  color: blackColor,
                  fontWeight: FontWeight.w600),
              // =-=------- sub Total --------=-=
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                    title: "Sub Total",
                  ),
                  smallText(
                    title: "\$ 14.00",
                  ),
                ],
              ),

              // =-=------- Discount --------=-=
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                    title: "Discount",
                  ),
                  smallText(
                    title: "\$ 00.00",
                  ),
                ],
              ),
              // =-=------- Total --------=-=
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  largeText(title: "Total", fontWeight: FontWeight.w700),
                  largeText(title: "\$ 14.00", fontWeight: FontWeight.w700),
                ],
              ),
              // =-=------- Checkout Button --------=-=
              SizedBox(
                height: 60.h,
              ),
              Row(
                children: [
                  GetBuilder<CartController>(
                      init: CartController(),
                      builder: (controller) {
                        return Checkbox(
                            value: controller.isChecked,
                            onChanged: (check) {
                              controller.isChecked = check!;
                              controller.update();
                            });
                      }),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          commonText(
                              title: "I have read and agree to the ",
                              textStyle: TextStyle(fontSize: 32.sp)),
                          InkWell(
                              onTap: () {
                                Get.to(() => TermsAndConditionScreen());
                              },
                              child: commonText(
                                  title: "Terms & Condition,",
                                  textStyle: TextStyle(
                                      fontSize: 32.sp, color: Colors.blue))),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.to(() => PrivacyPolicyScreen());
                              },
                              child: commonText(
                                  title: "Privacy Policy",
                                  textStyle: TextStyle(
                                      fontSize: 32.sp, color: Colors.blue))),
                          commonText(
                              title: " of “iFresh Originals”",
                              textStyle: TextStyle(
                                fontSize: 32.sp,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // =-=------- Checkout Button --------=-=
              SizedBox(
                height: 60.h,
              ),
              GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) {
                  return controller.isChecked ? commonButton(
                      buttonName: "Checkout",
                      onTap: () {
                        FirebaseAuth.instance.currentUser!.isAnonymous ?
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialogWidget();
                            }) :  Get.to(() => ShippingAddressScreen());
                        
                      },
                      buttonColor: redColor,
                      buttonHeight: 140.h,
                      buttonWidth: 1.sw,
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500))
                      :
                  commonButton(
                      buttonName: "Checkout",
                      buttonColor: whiteColor,
                      buttonHeight: 140.h,
                      buttonWidth: 1.sw,
                      textStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500));
                }
              )
            ],
          ),
        ),
      )),
    );
  }
}
