import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import '../../../constant/constants.dart';
import '../../../controller/create_new_design_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:get/get.dart';
import '../../../controller/functionality_on_image_controller.dart';
import '../../../controller/home_controller.dart';

Widget backImageOfNewDesign(context) {

  FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());
  HomeController homeController = Get.put(HomeController());

  return GetBuilder<CreateNewDesignController>(
    init: CreateNewDesignController(),
    builder: (controller) {
      return RepaintBoundary(
        key: functionalityOnImageController.backGlobalKey,
        child: Container(
            height: 280,
            width: 700.w,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // border: Border.all(color: blackColor,width: 1),
                image: DecorationImage(image: AssetImage("${homeController.selectedBackImage}",),
                    fit: BoxFit.fill,colorFilter: ColorFilter.mode(controller.selectedColorsForShirtSecondImage ?? Colors.white, BlendMode.modulate))
            ),
          child:  Stack(
            // clipBehavior: Clip.,
            // overflow: Overflow.visible,
            children: [
              // Flexible(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Image(image: AssetImage("${controller.selectedFrontImage}"),height: 270,
              //         width: 700.w, fit: BoxFit.cover,),
              //     ],
              //   ),
              // ),
              Padding(
                padding:  EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Container(
                    width: 105,
                    height: 120,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
                    child: Center(child: Text(".")),
                  ),
                ),
              ),

              // Center(child: Image(image:  AssetImage("assets/Asset 12.png",),color: Colors.red.withOpacity(1))),
              //-----------------------------------------------
              //---------- =======  Text  ======= ----------
              //-----------------------------------------------
              for(var i=0; i< controller.textListForSecondImage.length;i++)
                Positioned(

                    left: controller.textListForSecondImage[i].left,
                    top: controller.textListForSecondImage[i].top,
                    child: Tooltip(
                      message: "DoubleTap To Remove",
                      textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                      showDuration: 1.seconds,
                      height: 60.h,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller.removeTextIndexSecondImage = i;
                          controller.update();
                          controller.removeTextSecondImage();
                        },
                        onTap: (){
                          controller.textSelected = true;
                          controller.currentIndexOfTextSecondImage = i;
                          controller.update();
                        },

                        child: Draggable(
                          feedback: Text("${controller.textListForSecondImage[i].text}", style: TextStyle(
                              color: controller.textListForSecondImage[i].color ?? blackColor, fontStyle: controller.textListForSecondImage[i].fontStyle,
                              fontSize: controller.textListForSecondImage[i].fontSize, fontWeight: controller.textListForSecondImage[i].fontWeight
                          ),),
                          child: Text("${controller.textListForSecondImage[i].text}", style: TextStyle(
                              color: controller.textListForSecondImage[i].color ?? blackColor,fontStyle: controller.textListForSecondImage[i].fontStyle,
                              fontSize: controller.textListForSecondImage[i].fontSize,fontWeight: controller.textListForSecondImage[i].fontWeight
                          ),),

                          onDragEnd: (drag) {

                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.textList[i].top = off.dy - 159;
                            // controller.textList[i].left = off.dx - 60;

                            if(off.dy > 300 ){
                              controller.textListForSecondImage[i].top = 160;
                              // controller.update();
                            }else if(off.dy < 230){
                              controller.textListForSecondImage[i].top = 70;
                              // controller.update();
                            }else{
                              controller.textListForSecondImage[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if(off.dx > 160 ){
                              controller.textListForSecondImage[i].left = 105;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.textListForSecondImage[i].left = 68;
                              // controller.update();
                            }else{
                              controller.textListForSecondImage[i].left =  off.dx-60;
                              // controller.update();
                            }

                            controller.update();

                          },
                        ),
                      ),
                    )
                ),

              //-----------------------------------------------
              //---------- =======  Sticker  ======= ----------
              //-----------------------------------------------
              for(var i=0; i< controller.stickerListSecondImage.length;i++)
                Positioned(

                    left: controller.stickerListSecondImage[i].left,
                    top: controller.stickerListSecondImage[i].top,
                    child: Tooltip(
                      message: "DoubleTap To Remove",
                      textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                      showDuration: 1.seconds,
                      height: 60.h,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller.removeStickerIndexSecondImage  = i;
                          controller.update();
                          controller.removeStickerSecondImage();
                        },

                        child: Draggable(
                          feedback:   Container(
                            height: 150.w,
                            width: 150.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage("${controller.stickerListSecondImage[i].sticker}"),fit: BoxFit.scaleDown)),
                          ),

                          child:   Container(
                            height: 150.w,
                            width: 150.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage("${controller.stickerListSecondImage[i].sticker}"),fit: BoxFit.scaleDown)),
                          ),

                          onDragEnd: (drag) {
                            // print(drag.offset);
                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);
                            //
                            //  controller.stickerList[i].top = off.dy - 159;
                            //  controller.stickerList[i].left =  off.dx - 60;
                            // controller.update();

                            if(off.dy > 300 ){
                              controller.stickerListSecondImage[i].top = 140;
                              // controller.update();
                            }else if(off.dy < 210){
                              controller.stickerListSecondImage[i].top = 70;
                              // controller.update();
                            }else{
                              controller.stickerListSecondImage[i].top =  off.dy-159;
                              // controller.update();
                            }


                            if(off.dx > 200 ){
                              controller.stickerListSecondImage[i].left = 117;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.stickerListSecondImage[i].left = 65;
                              // controller.update();
                            }else{
                              controller.stickerListSecondImage[i].left =  off.dx-60;
                              // controller.update();
                            }
                            controller.update();
                          },
                        ),
                      ),
                    )
                ),

              //-----------------------------------------------
              //---------- =======  Cam or Gallery Image  ======= ----------
              //-----------------------------------------------
              for(var i=0; i< controller.imageListSecondImage.length;i++)
                Positioned(

                    left: controller.imageListSecondImage[i].left,
                    top: controller.imageListSecondImage[i].top,
                    child: Tooltip(
                      message: "DoubleTap To Remove",
                      textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                      showDuration: 1.seconds,
                      height: 60.h,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller.removeImageIndexSecondImage = i;
                          controller.update();
                          controller.removeImageSecondImage();
                        },

                        child: Draggable(
                          feedback:   controller.imageListSecondImage[i].image == null ? Container() :  Container(
                            height: 200.w,
                            width: 200.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: FileImage(controller.imageListSecondImage[i].image!),fit: BoxFit.scaleDown)),
                          ),


                          child: controller.imageListSecondImage[i].image == null ? Container() : Container(
                            height: 200.w,
                            width: 200.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: FileImage(controller.imageListSecondImage[i].image! ),fit: BoxFit.scaleDown),
                                color: Colors.transparent),
                          ),

                          onDragEnd: (drag) {
                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.imageList[i].top = off.dy - 159;
                            // controller.imageList[i].left = off.dx - 60;

                            if(off.dy > 280 ){
                              controller.imageListSecondImage[i].top = 110;
                              // controller.update();
                            }else if(off.dy < 240){
                              controller.imageListSecondImage[i].top = 75;
                              // controller.update();
                            }else{
                              controller.imageListSecondImage[i].top =  off.dy-159;
                              // controller.update();
                            }


                            if(off.dx > 180 ){
                              controller.imageListSecondImage[i].left = 110;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.imageListSecondImage[i].left = 55;
                              // controller.update();
                            }else{
                              controller.imageListSecondImage[i].left =  off.dx-60;
                              // controller.update();
                            }
                            controller.update();

                          },
                        ),
                      ),
                    )
                ),

              // controller.createTextController.text.isNotEmpty ? Positioned(
              //     left: 0,
              //     bottom: 0,
              //     child: Text(controller.createTextController.text,
              //      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.3) ),
              //     )) : const SizedBox.shrink()
            ],
          ),
        ),
      );
    }
  );
}