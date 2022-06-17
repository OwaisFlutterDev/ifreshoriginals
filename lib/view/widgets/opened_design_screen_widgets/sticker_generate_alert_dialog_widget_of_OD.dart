import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AlertDialog stickerGenerateAlertDialogOfOD() {
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
                            largeText(title: "Choose Sticker",color: blackColor,fontWeight: FontWeight.bold),
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
                        Obx(() =>
                            Container(
                              width: 0.9.sw,
                              height: 440.h,
                              color: Colors.transparent,
                              // color: Colors.blue[100]
                              child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    // maxCrossAxisExtent: 400.h,
                                    crossAxisCount: 4,
                                    mainAxisExtent: 220.h,
                                  ),
                                  itemCount: controller.stickersDataList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return  InkWell(
                                        onTap: () {
                                          controller.selectedStickerOfOD = controller.stickersDataList[index].stickerImage;
                                          controller.selectedIndexOfStickerOfOD = index;
                                          controller.update();
                                          print("1st image function");
                                        },
                                        child: Container(
                                          height: 190.w,
                                          width: 150.h,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: controller.selectedIndexOfStickerOfOD == index ? Border.all(color: redColor,width: 1) : Border.all(color: Colors.transparent,width: 1),
                                            borderRadius: controller.selectedIndexOfStickerOfOD == index ? BorderRadius.circular(20.r) : BorderRadius.circular(0.r),
                                            // image: DecorationImage(image: AssetImage("${controller.stickerAssetList[index].sticker}"),fit: BoxFit.scaleDown)
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 135.w,
                                                width: 135.h,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    image: DecorationImage(image: CachedNetworkImageProvider("${controller.stickersDataList[index].stickerImage}"),fit: BoxFit.scaleDown)),
                                              ),
                                              SizedBox(height: 10.h,
                                              ),
                                              Center(child: commonText(title: "${controller.stickersDataList[index].stickerName}", textStyle: TextStyle(fontSize: 9),textAlign: TextAlign.center))
                                            ],
                                          ),
                                        )

                                    );
                                  }),
                            ),),

                        SizedBox(height: 50.h,),
                        // --------===------========  Done Button =======------===--------
                        commonButton(
                            buttonName: "Done",
                            onTap: (){
                              controller.addNewStickerOfOD();
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