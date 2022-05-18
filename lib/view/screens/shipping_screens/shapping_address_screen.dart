import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/constant/form_validator_constant.dart';
import 'package:ifreshoriginals_userapp/controller/order_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/shipping_screens/shipping_method_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingAddressScreen extends StatelessWidget{
  ShippingAddressScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController(), permanent: true);

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
                  key: orderController.orderFormKey,
                  child: Column(
                    children: [
                      commonTextFormField(
                        hintText: "Email",
                        prefixIcon: (CupertinoIcons.mail),
                        controller: orderController.emailController,
                        validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "First Name",
                        prefixIcon: (CupertinoIcons.person),
                        controller: orderController.firstNameController,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                          hintText: "Last Name",
                          prefixIcon: (CupertinoIcons.person),
                          controller: orderController.lastNameController,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "Phone Number",
                        prefixIcon: (CupertinoIcons.phone),
                        controller: orderController.phoneController,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "Address",
                        prefixIcon: (CupertinoIcons.location),
                        controller: orderController.addressController,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormField(
                        hintText: "City",
                        prefixIcon: (CupertinoIcons.building_2_fill),
                          controller: orderController.cityController,
                          validator: FormValidatorConstant.commonValidator

                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormFieldForImage(
                        hintText: "Country",
                        prefixIcon: "assets/Asset 71.png",
                          controller: orderController.countryController,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormFieldForImage(
                        hintText: "State",
                        prefixIcon: "assets/Asset 72.png",
                        controller: orderController.stateController,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 50.h,),
                      commonTextFormFieldForImage(
                        hintText: "Zip Code",
                        prefixIcon: "assets/Asset 73.png",
                        controller: orderController.zipCodeController,
                        keyboardType: TextInputType.number,
                          validator: FormValidatorConstant.commonValidator
                      ),
                      SizedBox(height: 90.h,),
                      commonButton(
                        onTap: (){
                          if (orderController.orderFormKey.currentState!.validate()) {
                            Get.to(() => ShippingMethodScreen());
                          } else {
                            Get.snackbar("Shipping Address",
                                "Please Fill All The Fields",
                                duration: Duration(seconds: 3));
                          }

                        },
                        buttonWidth: 1.sw,

                        buttonColor: redColor,
                        buttonName: "Proceed",
                        textColor: whiteColor,
                      ),
                      SizedBox(height: 40.h,),

                  ],),
                )

              ],),
          ),),),
    );
  }
}