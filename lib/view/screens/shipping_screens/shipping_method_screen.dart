import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/payment_method_controller.dart';
import 'package:ifreshoriginals_userapp/controller/shipping_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/shipping_screens/payment_methods_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShippingMethodScreen extends StatelessWidget{
   ShippingMethodScreen({Key? key}) : super(key: key);
  final PaymentMethodController _paymentMethodController = Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
        title: "Shipping Method",
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
            padding:  EdgeInsets.symmetric(horizontal: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                // =-----= ===== title ===== =-----=
                headerThree(
                  title: 'Shipping Information',
                  color: blackColor,
                  fontWeight: FontWeight.w700
                ),

                // =-----= ===== Email ===== =-----=
                SizedBox(height: 60.h,),
                largeText(
                    title: 'Contact Email',
                    fontWeight: FontWeight.w600
                ),
                SizedBox(height: 15.h,),
                Wrap(
                  children: [
                    smallText(
                      title: "loremipsum@gmail.com"
                    ),
                  ],
                ),

                // =-----= ===== Shipping Address ===== =-----=
                SizedBox(height: 60.h,),
                largeText(
                  title: 'Shipping Address',
                    fontWeight: FontWeight.w600
                ),
                SizedBox(height: 15.h,),
                Wrap(
                  children: [
                    smallText(
                        title: "871 E, Lorem Street, Washington DC, USA"
                    ),
                  ],
                ),

                // =-----= ===== Shipping Address ===== =-----=
                SizedBox(height: 90.h,),
                headerThree(
                  title: 'Shipping Method',
                    color: blackColor,
                    fontWeight: FontWeight.w700
                ),
                SizedBox(height: 30.h,),

                // =-----= ===== CheckedBoxes  ===== =-----=
                Row(
                  children: [
                    GetBuilder<ShippingController>(
                      init: ShippingController(),
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  ---- ==== checkbox One ==== ----
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                             Checkbox(
                                 value: controller.isCheckedOne,
                                 onChanged: (check) {
                                   controller.isCheckedOne = check!;
                                   controller.isCheckedThree = false;
                                   controller.isCheckedTwo = false;
                                   controller.update();
                                 }),
                             SizedBox(width: 20.w,),
                             commonText(title: "Standard (Est Delivery in 8-10 Business Days)", textStyle: TextStyle(
                                 fontSize: 28.sp,color: Colors.black,fontWeight: FontWeight.w600
                             )),
                             SizedBox(width: 35.w,),
                             smallText(title: "\$14.99",fontWeight: FontWeight.w700,)

                           ],),
                            SizedBox(height: 40.h,),
                            //  ---- ==== checkbox One ==== ----
                            Row(children: [
                              Checkbox(
                                  value: controller.isCheckedTwo,
                                  onChanged: (check) {
                                    controller.isCheckedTwo = check!;
                                    controller.isCheckedThree = false;
                                    controller.isCheckedOne = false;
                                    controller.update();
                                  }),
                              SizedBox(width: 20.w,),
                              commonText(title: "Standard (Est Delivery in 4-8 Business Days)", textStyle: TextStyle(
                                  fontSize: 28.sp,color: Colors.black,fontWeight: FontWeight.w600
                              )),
                              SizedBox(width: 35.w,),
                              smallText(title: "\$17.99",fontWeight: FontWeight.w700,)
                            ],),
                            SizedBox(height: 40.h,),
                            //  ---- ==== checkbox One ==== ----
                            Row(children: [
                              Checkbox(
                                  value: controller.isCheckedThree,
                                  onChanged: (check) {
                                    controller.isCheckedThree = check!;
                                    controller.isCheckedTwo = false;
                                    controller.isCheckedOne = false;
                                    controller.update();
                                  }),
                              SizedBox(width: 20.w,),
                              commonText(title: "Standard (Est Delivery in 3-6 Business Days)", textStyle: TextStyle(
                                  fontSize: 28.sp,color: Colors.black,fontWeight: FontWeight.w600
                              )),
                              SizedBox(width: 35.w,),
                              smallText(title: "\$21.99",fontWeight: FontWeight.w700,)

                            ],),
                            SizedBox(height: 40.h,)
                        ],);
                      }
                    )
                ],),

                // =-----= ===== Proceed Button  ===== =-----=
                SizedBox(height: 90.h,),
                commonButton(
                  buttonName: "Proceed",
                  buttonColor: redColor,
                  buttonWidth: 1.sw,
                    textColor: whiteColor,
                  onTap: () {
                    _paymentMethodController.startCardEntryFlowMethod();
                    // Get.to(() => PaymentMethodsScreen());
                  }
                )

              ],),
          ),),),
    );
  }
}