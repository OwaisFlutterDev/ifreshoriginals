import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            height: 360,
            width: 940.w,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // border: Border.all(color: blackColor,width: 1),
                image: DecorationImage(image: AssetImage("${homeController.selectedBackImage}",),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(controller.convertedColorForSecondShirt ?? whiteColor, BlendMode.modulate)
                )
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
              // Center(
              //   child: Container(
              //     width: 140,
              //     height: 190,
              //     decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
              //     child: Center(child: Text(".")),
              //   ),
              // ),

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
                          feedback: Text("${controller.textListForSecondImage[i].text}",
                            style: GoogleFonts.getFont('${controller.textListForSecondImage[i].fontFamily}' , textStyle: TextStyle(
                                color: Color(controller.textListForSecondImage[i].color ?? blackHexColor), fontStyle: controller.textListForSecondImage[i].fontStyle,
                                fontSize: controller.textListForSecondImage[i].fontSize, fontWeight: controller.textListForSecondImage[i].fontWeight
                            )),
                          ),
                          child: Text("${controller.textListForSecondImage[i].text}",
                            style: GoogleFonts.getFont('${controller.textListForSecondImage[i].fontFamily}' , textStyle: TextStyle(
                                color: Color(controller.textListForSecondImage[i].color ?? blackHexColor), fontStyle: controller.textListForSecondImage[i].fontStyle,
                                fontSize: controller.textListForSecondImage[i].fontSize, fontWeight: controller.textListForSecondImage[i].fontWeight
                            )),
                          ),

                          onDragEnd: (drag) {

                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.textList[i].top = off.dy - 159;
                            // controller.textList[i].left = off.dx - 60;

                            if(off.dy > 400 ){
                              controller.textListForSecondImage[i].top = 243;
                              // controller.update();
                            }else if(off.dy < 230){
                              controller.textListForSecondImage[i].top = 80;
                              // controller.update();
                            }else{
                              controller.textListForSecondImage[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if(
                            controller.textListForSecondImage[i].fontSize! >= 10 ? off.dx > 235 :
                            controller.textListForSecondImage[i].fontSize! >= 20 ? off.dx > 190 :
                            controller.textListForSecondImage[i].fontSize! >= 30 ? off.dx > 160 :
                            controller.textListForSecondImage[i].fontSize! >= 40 ? off.dx > 125 :
                            controller.textListForSecondImage[i].fontSize! >= 50 ? off.dx > 105 :
                            off.dx > 270
                            )
                            {
                              controller.textListForSecondImage[i].fontSize! >= 55 ?  controller.textListForSecondImage[i].left = 75 :
                              controller.textListForSecondImage[i].fontSize! >= 40 ?  controller.textListForSecondImage[i].left = 100 :
                              controller.textListForSecondImage[i].fontSize! >= 30 ?  controller.textListForSecondImage[i].left = 142 :
                              controller.textListForSecondImage[i].fontSize! >= 20 ?  controller.textListForSecondImage[i].left = 155 :
                              controller.textListForSecondImage[i].fontSize! >= 10 ?  controller.textListForSecondImage[i].left = 175 :
                              controller.textListForSecondImage[i].left = 200;
                              // controller.imageList[i].left = 160;
                              print("${  controller.textListForSecondImage[i].fontSize!}");

                            }else if(off.dx < 140){
                              controller.textListForSecondImage[i].left = 84;
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
                        onTap: (){
                          controller.stickerSelected = true;
                          controller.currentIndexOfStickerOfSecImage = i;
                          controller.update();
                        },

                        child: Draggable(
                          feedback:   Container(
                            height: controller.stickerListSecondImage[i].stickerHeight,
                            width: controller.stickerListSecondImage[i].stickerWeight,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage("${controller.stickerListSecondImage[i].sticker}"),fit: BoxFit.scaleDown)),
                          ),

                          child:   Container(
                            height: controller.stickerListSecondImage[i].stickerHeight,
                            width: controller.stickerListSecondImage[i].stickerWeight,
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


                            if(
                            controller.stickerListSecondImage[i].stickerHeight! >= 50 ? off.dy > 400 :
                            controller.stickerListSecondImage[i].stickerHeight! >= 70 ? off.dy > 360 :
                            controller.stickerListSecondImage[i].stickerHeight! >= 90 ? off.dy > 320 :
                            controller.stickerListSecondImage[i].stickerHeight! >= 110 ? off.dy > 300 :
                            off.dy > 450
                            )
                            {
                              controller.stickerListSecondImage[i].stickerHeight! >= 110 ? controller.stickerListSecondImage[i].top = 170 :
                              controller.stickerListSecondImage[i].stickerHeight! >= 90 ? controller.stickerListSecondImage[i].top = 190 :
                              controller.stickerListSecondImage[i].stickerHeight! >= 70 ? controller.stickerListSecondImage[i].top = 210 :
                              controller.stickerListSecondImage[i].stickerHeight! >= 50 ? controller.stickerListSecondImage[i].top = 230 :
                              controller.stickerListSecondImage[i].top = 256;
                              // controller.update();
                              print("${controller.stickerListSecondImage[i].stickerHeight!}");
                            }else if(off.dy < 230){
                              controller.stickerListSecondImage[i].top = 80;
                              // controller.update();
                            }else{
                              controller.stickerListSecondImage[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if( controller.stickerListSecondImage[i].stickerWeight! >= 50 ? off.dx > 235 :
                            controller.stickerListSecondImage[i].stickerWeight! >= 70 ? off.dx > 205 :
                            controller.stickerListSecondImage[i].stickerWeight! >= 90 ? off.dx > 180 :
                            controller.stickerListSecondImage[i].stickerWeight! >= 110 ? off.dx > 145 :
                            off.dx > 270
                            )
                            {
                              controller.stickerListSecondImage[i].stickerWeight! >= 110 ?  controller.stickerListSecondImage[i].left = 116 :
                              controller.stickerListSecondImage[i].stickerWeight! >= 90 ?  controller.stickerListSecondImage[i].left = 140 :
                              controller.stickerListSecondImage[i].stickerWeight! >= 70 ?  controller.stickerListSecondImage[i].left = 155 :
                              controller.stickerListSecondImage[i].stickerWeight! >= 50 ?  controller.stickerListSecondImage[i].left = 176 :
                              controller.stickerListSecondImage[i].left = 200;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.stickerListSecondImage[i].left = 84;
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
                        onTap: (){
                          controller.imageSelected = true;
                          controller.currentIndexOfImageOfSI = i;
                          controller.update();
                        },

                        child: Draggable(
                            feedback:   controller.imageListSecondImage[i].image == null ? Container() :  Container(
                            height: controller.imageListSecondImage[i].imageHeight,
                            width: controller.imageListSecondImage[i].imageWeight,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: FileImage(controller.imageListSecondImage[i].image!),fit: BoxFit.fill)),
                          ),

                          child: controller.imageListSecondImage[i].image == null ? Container() : Container(
                            height: controller.imageListSecondImage[i].imageHeight,
                            width: controller.imageListSecondImage[i].imageWeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: FileImage(controller.imageListSecondImage[i].image! ),fit: BoxFit.fill),
                                color: Colors.transparent),
                          ),

                          onDragEnd: (drag) {
                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);


                            if(
                            controller.imageListSecondImage[i].imageHeight! >= 50 ? off.dy > 400 :
                            controller.imageListSecondImage[i].imageHeight! >= 70 ? off.dy > 360 :
                            controller.imageListSecondImage[i].imageHeight! >= 90 ? off.dy > 320 :
                            controller.imageListSecondImage[i].imageHeight! >= 110 ? off.dy > 300 :
                            controller.imageListSecondImage[i].imageHeight! >= 130 ?off.dy > 280  :
                            off.dy > 450
                            )
                            {
                              controller.imageListSecondImage[i].imageHeight! >= 130 ? controller.imageListSecondImage[i].top = 160 :
                              controller.imageListSecondImage[i].imageHeight! >= 110 ? controller.imageListSecondImage[i].top = 185 :
                              controller.imageListSecondImage[i].imageHeight! >= 90 ? controller.imageListSecondImage[i].top = 210 :
                              controller.imageListSecondImage[i].imageHeight! >= 70 ? controller.imageListSecondImage[i].top = 230 :
                              controller.imageListSecondImage[i].imageHeight! >= 50 ? controller.imageListSecondImage[i].top = 240 :
                              controller.imageListSecondImage[i].top = 256;
                              print("${controller.imageListSecondImage[i].imageHeight!}");
                              // controller.update();
                            }else if(off.dy < 240){
                              controller.imageListSecondImage[i].top = 80;
                              // controller.update();
                            }else{
                              controller.imageListSecondImage[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if(
                            controller.imageListSecondImage[i].imageWeight! >= 50 ? off.dx > 235 :
                            controller.imageListSecondImage[i].imageWeight! >= 70 ? off.dx > 190 :
                            controller.imageListSecondImage[i].imageWeight! >= 90 ? off.dx > 160 :
                            controller.imageListSecondImage[i].imageWeight! >= 110 ? off.dx > 125 :
                            controller.imageListSecondImage[i].imageWeight! >= 130 ? off.dx > 105 :
                            off.dx > 270
                            )
                            {
                              controller.imageListSecondImage[i].imageWeight! >= 130 ?  controller.imageListSecondImage[i].left = 95 :
                              controller.imageListSecondImage[i].imageWeight! >= 110 ?  controller.imageListSecondImage[i].left = 116 :
                              controller.imageListSecondImage[i].imageWeight! >= 90 ?  controller.imageListSecondImage[i].left = 140 :
                              controller.imageListSecondImage[i].imageWeight! >= 70 ?  controller.imageListSecondImage[i].left = 155 :
                              controller.imageListSecondImage[i].imageWeight! >= 50 ?  controller.imageListSecondImage[i].left = 176 :
                              controller.imageListSecondImage[i].left = 195;
                              // controller.imageList[i].left = 160;
                              print("${  controller.imageListSecondImage[i].imageWeight!}");
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.imageListSecondImage[i].left = 84;
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