import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AlertDialog imagePickerAlertDialogWidgetSecondImageOfOd() {
  return AlertDialog(
      scrollable: true,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(15))),
      backgroundColor: bgColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 40,vertical: 0),
      content: Builder(
          builder: (context) {
            return GetBuilder<OpenedDesignController>(
                init: OpenedDesignController(),
                builder: (controller) {
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- === button === ---
                        SizedBox(height: 10.h,),
                        InkWell(
                          onTap: (){
                            controller.imageFromGallerySecondImageOfOd  = null;
                            controller.update();
                            controller.getImageFromCameraSecondImageOfOd();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              largeText(title: "Take Photo",fontWeight: FontWeight.w500),
                              Image(image: AssetImage("assets/Asset 55.png"),
                                width: 100.w,height: 100.h,)
                            ],),
                        ),
                        SizedBox(height: 60.h,),
                        InkWell(
                          onTap: (){
                            controller.getImageFromGallerySecondImageOfOd();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              largeText(title: "Choose Photo",fontWeight: FontWeight.w500),
                              Image(image: AssetImage("assets/Asset 56.png"),
                                width: 100.w,height: 100.h,)
                            ],),
                        ),
                        SizedBox(height: 50.h,),
                        commonButton(
                            buttonName: "Done",
                            onTap: (){
                              controller.addNewImageSecondImageOfOd();
                            },
                            buttonColor: redColor,
                            textColor: whiteColor,
                            buttonWidth: 1.sw
                        ),

                      ]);
                }
            ); })
  );
}