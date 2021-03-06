import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AlertDialog shirtColorAlertDialogWidgetOfOd() {
  // FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());
  return AlertDialog(
      scrollable: true,
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(15))),
      backgroundColor: bgColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
      content: Builder(
          builder: (context) {
            return GetBuilder<OpenedDesignController>(
                init: OpenedDesignController(),
                builder: (controller) {
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- === title cross button === ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            SizedBox(width: 20.w,),
                            largeText(title: "Choose Color",color: blackColor,fontWeight: FontWeight.bold),
                            InkWell(
                                onTap: (){ Get.back();},
                                child: Container(
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 4.r,color: blackColor)
                                    ),
                                    child: Center(child: Icon(CupertinoIcons.clear, color: redColor,size: 40.r,)))
                            )
                          ],),

                        // -------- === colors buttons === --------
                        SizedBox(height: 50.h,),
                        Container(
                          width: 0.9.sw,
                          height: 650.h,
                          color: Colors.transparent,
                          // color: Colors.blue[100]
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                // maxCrossAxisExtent: 400.h,
                                crossAxisCount: 4,
                                mainAxisExtent: 300.h,
                              ),
                              itemCount: controller.colorsListOfOd.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return  InkWell(
                                    onTap:  ()   {
                                      controller.selectedColorsForShirt = controller.colorsListOfOd[index].color;
                                      controller.selectIndexColorsForShirt = index;
                                      controller.hexToColor();
                                      controller.update();
                                    } ,
                                    child: Container(
                                      height: 250.h,
                                      width: 250.w,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: controller.selectIndexColorsForShirt == index ? Border.all(color: redColor,width: 1) : Border.all(color: Colors.transparent,width: 1),
                                        borderRadius: controller.selectIndexColorsForShirt == index ? BorderRadius.circular(20.r) : BorderRadius.circular(0.r),
                                        // image: DecorationImage(image: AssetImage("${controller.stickerAssetList[index].sticker}"),fit: BoxFit.scaleDown)
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200.w,
                                            width: 200.h,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                image: DecorationImage(image: AssetImage("${controller.colorsListOfOd[index].image}"),fit: BoxFit.scaleDown)),
                                          ),
                                          SizedBox(height: 10.h,
                                          ),
                                          Center(child: smallText(title: "${controller.colorsListOfOd[index].name}"))
                                        ],
                                      ),
                                    )
                                );
                              }),
                        ),

                        SizedBox(height: 50.h,),
                        // --------===------========  Done Button =======------===--------
                        commonButton(
                            buttonName: "Done",
                            onTap: (){
                              Get.back();
                            },
                            buttonColor: redColor,
                            textColor: whiteColor,
                            buttonWidth: 1.sw
                        ),
                        SizedBox(height: 10.h,),

                      ]);
                }
            ); })
  );
}