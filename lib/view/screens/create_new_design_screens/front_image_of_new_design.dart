import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import '../../../controller/create_new_design_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:get/get.dart';

Widget frontImageOfNewDesign( context) {

  FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());
  HomeController homeController = Get.put(HomeController());

  return GetBuilder<CreateNewDesignController>(
    init: CreateNewDesignController(),
    builder: (controller) {
      return RepaintBoundary(
        key: functionalityOnImageController.frontGlobalKey,
        child: Container(
          height: 280,
          width: 700.w,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: blackColor,width: 1),
              image: DecorationImage(image: AssetImage("${homeController.selectedFrontImage}",),
                  fit: BoxFit.cover,colorFilter: ColorFilter.mode(controller.selectedColorsForShirt ?? Colors.white, BlendMode.modulate))
          ),
          child: Stack(
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
              for(var i=0; i< controller.textList.length;i++)
                Positioned(

                    left: controller.textList[i].left,
                    top: controller.textList[i].top,
                    child: Tooltip(
                      message: "DoubleTap To Remove",
                      textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                      showDuration: 1.seconds,
                      height: 60.h,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller.removeTextIndex = i;
                          controller.update();
                          controller.removeText();
                        },
                        onTap: (){
                          controller.textSelected = true;
                          controller.currentIndexOfText = i;
                          controller.update();
                        },

                        child: Draggable(
                          feedback: Text("${controller.textList[i].text}", style: TextStyle(
                              color: controller.textList[i].color ?? blackColor, fontStyle: controller.textList[i].fontStyle,
                              fontSize: controller.textList[i].fontSize, fontWeight: controller.textList[i].fontWeight
                          ),),
                          child: Text("${controller.textList[i].text}", style: TextStyle(
                              color: controller.textList[i].color ?? blackColor,fontStyle: controller.textList[i].fontStyle,
                              fontSize: controller.textList[i].fontSize,fontWeight: controller.textList[i].fontWeight
                          ),),

                          onDragEnd: (drag) {

                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.textList[i].top = off.dy - 159;
                            // controller.textList[i].left = off.dx - 60;

                            if(off.dy > 300 ){
                              controller.textList[i].top = 160;
                              // controller.update();
                            }else if(off.dy < 230){
                              controller.textList[i].top = 70;
                              // controller.update();
                            }else{
                              controller.textList[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if(off.dx > 160 ){
                              controller.textList[i].left = 105;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.textList[i].left = 68;
                              // controller.update();
                            }else{
                              controller.textList[i].left =  off.dx-60;
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
              for(var i=0; i< controller.stickerList.length;i++)
                Positioned(

                    left: controller.stickerList[i].left,
                    top: controller.stickerList[i].top,
                    child: Tooltip(
                      message: "DoubleTap To Remove",
                      textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                      showDuration: 1.seconds,
                      height: 60.h,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller.removeStickerIndex = i;
                          controller.update();
                          controller.removeSticker();
                        },

                        child: Draggable(
                          feedback:   Container(
                            height: 150.w,
                            width: 150.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage("${controller.stickerList[i].sticker}"),fit: BoxFit.scaleDown)),
                          ),

                          child:   Container(
                            height: 150.w,
                            width: 150.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage("${controller.stickerList[i].sticker}"),fit: BoxFit.scaleDown)),
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
                              controller.stickerList[i].top = 140;
                              // controller.update();
                            }else if(off.dy < 210){
                              controller.stickerList[i].top = 70;
                              // controller.update();
                            }else{
                              controller.stickerList[i].top =  off.dy-159;
                              // controller.update();
                            }


                            if(off.dx > 200 ){
                              controller.stickerList[i].left = 117;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.stickerList[i].left = 65;
                              // controller.update();
                            }else{
                              controller.stickerList[i].left =  off.dx-60;
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
              for(var i=0; i< controller.imageList.length;i++)
                Positioned(

                    left: controller.imageList[i].left,
                    top: controller.imageList[i].top,
                    child: Tooltip(
                      message: "DoubleTap To Remove",
                      textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                      showDuration: 1.seconds,
                      height: 60.h,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller.removeImageIndex = i;
                          controller.update();
                          controller.removeImage();
                        },

                        child: Draggable(
                          feedback:   controller.imageList[i].image == null ? Container() :  Container(
                            height: 200.w,
                            width: 200.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: FileImage(controller.imageList[i].image!),fit: BoxFit.scaleDown)),
                          ),


                          child: controller.imageList[i].image == null ? Container() : Container(
                            height: 200.w,
                            width: 200.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: FileImage(controller.imageList[i].image! ),fit: BoxFit.scaleDown),
                                color: Colors.transparent),
                          ),

                          onDragEnd: (drag) {
                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.imageList[i].top = off.dy - 159;
                            // controller.imageList[i].left = off.dx - 60;

                            if(off.dy > 280 ){
                              controller.imageList[i].top = 110;
                              // controller.update();
                            }else if(off.dy < 240){
                              controller.imageList[i].top = 75;
                              // controller.update();
                            }else{
                              controller.imageList[i].top =  off.dy-159;
                              // controller.update();
                            }


                            if(off.dx > 180 ){
                              controller.imageList[i].left = 110;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.imageList[i].left = 55;
                              // controller.update();
                            }else{
                              controller.imageList[i].left =  off.dx-60;
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
          )
        ),
      );
    }
  );
}