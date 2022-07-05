
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:get/get.dart';

Widget frontImageOfOpenedDesign( context) {

  FunctionalityOnOpenedDesignController functionalityOnImageController = Get.put(FunctionalityOnOpenedDesignController());
  HomeController homeController = Get.put(HomeController());

  return GetBuilder<OpenedDesignController>(
      init: OpenedDesignController(),
      builder: (controller) {
        return RepaintBoundary(
          key: functionalityOnImageController.frontGlobalKeyOfOD,
          child: Container(
              height: 360,
              width: 320,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  // border: Border.all(color: blackColor,width: 1),
                  image: DecorationImage(image: CachedNetworkImageProvider("${homeController.selectedFrontImageOfOpenedDesign}",),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(controller.convertedColorForShirt ?? Colors.white  , BlendMode.modulate)
                  )
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
                  // Padding(
                  //   padding:  EdgeInsets.only(bottom: 16),
                  //   child: Center(
                  //     child: Container(
                  //       width: 105,
                  //       height: 120,
                  //       decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
                  //       child: Center(child: Text(".")),
                  //     ),
                  //   ),
                  // ),

                  // Center(child: Image(image:  AssetImage("assets/Asset 12.png",),color: Colors.red.withOpacity(1))),
                  //-----------------------------------------------
                  //---------- =======  Text  ======= ----------
                  //-----------------------------------------------
                  for(var i=0; i< controller.textListOfOd.length;i++)
                    Positioned(

                        left: controller.textListOfOd[i].left,
                        top: controller.textListOfOd[i].top,
                        child: Tooltip(
                          message: "DoubleTap To Remove",
                          textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                          showDuration: 1.seconds,
                          height: 60.h,
                          child: GestureDetector(
                            onDoubleTap: () {
                              controller.removeTextIndexOfOd = i;
                              controller.update();
                              controller.removeTextOfOd();
                            },
                            onTap: (){
                              controller.textSelectedOfOd = true;
                              controller.currentIndexOfTextOfOd = i;
                              controller.update();
                            },

                            child: Draggable(
                              feedback:  Text(
                                  "${controller.textListOfOd[i].text}",
                                  style: GoogleFonts.getFont('${controller.textListOfOd[i].fontFamily}' , textStyle: TextStyle(
                                      color: Color(controller.textListOfOd[i].color ?? blackHexColor)  , fontStyle: controller.textListOfOd[i].fontStyle,
                                      fontSize: controller.textListOfOd[i].fontSize, fontWeight: controller.textListOfOd[i].fontWeight
                                  )), textAlign: controller.textListOfOd[i].textAlign
                              ),

                              child: Text("${controller.textListOfOd[i].text}",
                                style: GoogleFonts.getFont('${controller.textListOfOd[i].fontFamily}' , textStyle: TextStyle(
                                  color: Color(controller.textListOfOd[i].color ?? blackHexColor), fontStyle: controller.textListOfOd[i].fontStyle,
                                  fontSize: controller.textListOfOd[i].fontSize , fontWeight: controller.textListOfOd[i].fontWeight,
                                ), ), textAlign: controller.textListOfOd[i].textAlign ,
                              ),

                              onDragEnd: (drag) {

                                final renderBox = context.findRenderObject() as RenderBox;
                                Offset off = renderBox.globalToLocal(drag.offset);

                                // controller.textList[i].top = off.dy - 159;
                                // controller.textList[i].left = off.dx - 60;

                                if(off.dy > 400 ){
                                  controller.textListOfOd[i].top = 243;
                                  // controller.update();
                                }else if(off.dy < 230){
                                  controller.textListOfOd[i].top = 80;
                                  // controller.update();
                                }else{
                                  ScreenUtil().screenHeight >= 860 ? controller.textListOfOd[i].top =  off.dy-207 :
                                  ScreenUtil().screenHeight >= 800 ? controller.textListOfOd[i].top =  off.dy-200 :
                                  ScreenUtil().screenHeight >= 780 ? controller.textListOfOd[i].top =  off.dy-195 :

                                  ScreenUtil().screenHeight >= 650 ? controller.textListOfOd[i].top =  off.dy-178 :
                                  ScreenUtil().screenHeight >= 610 ? controller.textListOfOd[i].top =  off.dy-175 :

                                  ScreenUtil().screenHeight >= 570 ? controller.textListOfOd[i].top =  off.dy-167 :
                                  ScreenUtil().screenHeight >= 530 ? controller.textListOfOd[i].top =  off.dy-165 :
                                  ScreenUtil().screenHeight >= 490 ? controller.textListOfOd[i].top =  off.dy-160 :
                                  controller.textListOfOd[i].top =  off.dy-155;
                                  // controller.update();
                                }

                                if(
                                controller.textListOfOd[i].fontSize! >= 10 ? off.dx > 235 :
                                controller.textListOfOd[i].fontSize! >= 20 ? off.dx > 190 :
                                controller.textListOfOd[i].fontSize! >= 30 ? off.dx > 160 :
                                controller.textListOfOd[i].fontSize! >= 40 ? off.dx > 125 :
                                controller.textListOfOd[i].fontSize! >= 50 ? off.dx > 105 :
                                off.dx > 270
                                )
                                {
                                  controller.textListOfOd[i].fontSize! >= 50 ?  controller.textListOfOd[i].left = 68 :
                                  controller.textListOfOd[i].fontSize! >= 48 ?  controller.textListOfOd[i].left = 74 :
                                  controller.textListOfOd[i].fontSize! >= 44 ?  controller.textListOfOd[i].left = 80 :
                                  controller.textListOfOd[i].fontSize! >= 40 ?  controller.textListOfOd[i].left = 90 :
                                  controller.textListOfOd[i].fontSize! >= 36 ?  controller.textListOfOd[i].left = 100 :
                                  controller.textListOfOd[i].fontSize! >= 34 ?  controller.textListOfOd[i].left = 104 :
                                  controller.textListOfOd[i].fontSize! >= 32 ?  controller.textListOfOd[i].left = 118 :
                                  controller.textListOfOd[i].fontSize! >= 30 ?  controller.textListOfOd[i].left = 128 :
                                  controller.textListOfOd[i].fontSize! >= 27 ?  controller.textListOfOd[i].left = 135 :
                                  controller.textListOfOd[i].fontSize! >= 25 ?  controller.textListOfOd[i].left = 140 :
                                  controller.textListOfOd[i].fontSize! >= 22 ?  controller.textListOfOd[i].left = 151 :
                                  controller.textListOfOd[i].fontSize! >= 20 ?  controller.textListOfOd[i].left = 164 :
                                  controller.textListOfOd[i].fontSize! >= 17 ?  controller.textListOfOd[i].left = 168 :
                                  controller.textListOfOd[i].fontSize! >= 15 ?  controller.textListOfOd[i].left = 180 :
                                  controller.textListOfOd[i].fontSize! >= 12 ?  controller.textListOfOd[i].left = 187 :
                                  controller.textListOfOd[i].fontSize! >= 10 ?  controller.textListOfOd[i].left = 200 :
                                  controller.textListOfOd[i].fontSize! >= 5 ?   controller.textListOfOd[i].left = 210 :
                                  controller.textListOfOd[i].left = 220;

                                  // controller.imageList[i].left = 160;
                                  print("${  controller.textListOfOd[i].fontSize!}");

                                }else if(off.dx < 140){
                                  controller.textListOfOd[i].left = 84;
                                  // controller.update();
                                }else{
                                  ScreenUtil().screenWidth >= 430 ? controller.textListOfOd[i].left =  off.dx-50 :
                                  ScreenUtil().screenWidth >= 410 ? controller.textListOfOd[i].left =  off.dx-44 :
                                  ScreenUtil().screenWidth >= 390 ? controller.textListOfOd[i].left =  off.dx-39 :
                                  ScreenUtil().screenWidth >= 375 ? controller.textListOfOd[i].left =  off.dx-32 :
                                  ScreenUtil().screenWidth >= 360 ? controller.textListOfOd[i].left =  off.dx-23 :
                                  ScreenUtil().screenWidth >= 340 ? controller.textListOfOd[i].left =  off.dx-14 :
                                  ScreenUtil().screenWidth >= 320 ? controller.textListOfOd[i].left =  off.dx-3 :
                                  controller.textListOfOd[i].left =  off.dx-2 ;
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
                  for(var i=0; i< controller.stickerListFirstImageOfOD.length;i++)
                    Positioned(
                        left: controller.stickerListFirstImageOfOD[i].left,
                        top: controller.stickerListFirstImageOfOD[i].top,
                        child: Tooltip(
                          message: "DoubleTap To Remove",
                          textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                          showDuration: 1.seconds,
                          height: 60.h,
                          child: GestureDetector(
                            onDoubleTap: () {
                              controller.removeStickerIndexOfOD = i;
                              controller.update();
                              controller.removeStickerOfOD();
                            },
                            onTap: (){
                              controller.stickerSelected = true;
                              controller.currentIndexOfSticker = i;
                              controller.update();
                            },

                            child: Draggable(
                              feedback:   Container(
                                height: controller.stickerListFirstImageOfOD[i].stickerHeight,
                                width: controller.stickerListFirstImageOfOD[i].stickerWeight,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(image: CachedNetworkImageProvider("${controller.stickerListFirstImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                                  ),

                              child:   Container(
                                height: controller.stickerListFirstImageOfOD[i].stickerHeight,
                                width: controller.stickerListFirstImageOfOD[i].stickerWeight,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(image: CachedNetworkImageProvider("${controller.stickerListFirstImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                                  ),

                              onDragEnd: (drag) {
                                // print(drag.offset);
                                final renderBox = context.findRenderObject() as RenderBox;
                                Offset off = renderBox.globalToLocal(drag.offset);

                                if(
                                controller.stickerListFirstImageOfOD[i].stickerHeight! >= 50 ? off.dy > 400 :
                                controller.stickerListFirstImageOfOD[i].stickerHeight! >= 70 ? off.dy > 360 :
                                controller.stickerListFirstImageOfOD[i].stickerHeight! >= 90 ? off.dy > 320 :
                                controller.stickerListFirstImageOfOD[i].stickerHeight! >= 110 ? off.dy > 300 :
                                off.dy > 450
                                )
                                {
                                  controller.stickerListFirstImageOfOD[i].stickerHeight! >= 130 ? controller.stickerListFirstImageOfOD[i].top = 150 :
                                  controller.stickerListFirstImageOfOD[i].stickerHeight! >= 120 ? controller.stickerListFirstImageOfOD[i].top = 160 :
                                  controller.stickerListFirstImageOfOD[i].stickerHeight! >= 110 ? controller.stickerListFirstImageOfOD[i].top = 170 :
                                  controller.stickerListFirstImageOfOD[i].stickerHeight! >= 90 ? controller.stickerListFirstImageOfOD[i].top = 190 :
                                  controller.stickerListFirstImageOfOD[i].stickerHeight! >= 70 ? controller.stickerListFirstImageOfOD[i].top = 210 :
                                  controller.stickerListFirstImageOfOD[i].stickerHeight! >= 50 ? controller.stickerListFirstImageOfOD[i].top = 230 :
                                  controller.stickerListFirstImageOfOD[i].top = 256;
                                  // controller.update();
                                  print("${controller.stickerListFirstImageOfOD[i].stickerHeight!}");
                                }else if(off.dy < 230){
                                  controller.stickerListFirstImageOfOD[i].top = 80;
                                  // controller.update();
                                }else{
                                  ScreenUtil().screenHeight >= 860 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-207 :
                                  ScreenUtil().screenHeight >= 800 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-200 :
                                  ScreenUtil().screenHeight >= 780 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-195 :

                                  ScreenUtil().screenHeight >= 650 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-178 :
                                  ScreenUtil().screenHeight >= 610 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-175 :

                                  ScreenUtil().screenHeight >= 570 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-167 :
                                  ScreenUtil().screenHeight >= 530 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-165 :
                                  ScreenUtil().screenHeight >= 490 ? controller.stickerListFirstImageOfOD[i].top =  off.dy-160 :

                                  controller.stickerListFirstImageOfOD[i].top =  off.dy-155;
                                  // controller.update();
                                }

                                if( controller.stickerListFirstImageOfOD[i].stickerWeight! >= 50 ? off.dx > 235 :
                                controller.stickerListFirstImageOfOD[i].stickerWeight! >= 70 ? off.dx > 205 :
                                controller.stickerListFirstImageOfOD[i].stickerWeight! >= 90 ? off.dx > 180 :
                                controller.stickerListFirstImageOfOD[i].stickerWeight! >= 110 ? off.dx > 145 :
                                off.dx > 270
                                )
                                {
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 135 ?  controller.stickerListFirstImageOfOD[i].left = 105 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 130 ?  controller.stickerListFirstImageOfOD[i].left = 110 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 125 ?  controller.stickerListFirstImageOfOD[i].left = 115 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 120 ?  controller.stickerListFirstImageOfOD[i].left = 120 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 115 ?  controller.stickerListFirstImageOfOD[i].left = 125 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 110 ?  controller.stickerListFirstImageOfOD[i].left = 130 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 105 ?  controller.stickerListFirstImageOfOD[i].left = 135 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 100 ?  controller.stickerListFirstImageOfOD[i].left = 140 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 95 ?  controller.stickerListFirstImageOfOD[i].left = 145 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 90 ?  controller.stickerListFirstImageOfOD[i].left = 150 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 85 ?  controller.stickerListFirstImageOfOD[i].left = 155 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 80 ?  controller.stickerListFirstImageOfOD[i].left = 160 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 75 ?  controller.stickerListFirstImageOfOD[i].left = 165 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 70 ?  controller.stickerListFirstImageOfOD[i].left = 170 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 65 ?  controller.stickerListFirstImageOfOD[i].left = 175 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 60 ?  controller.stickerListFirstImageOfOD[i].left = 180 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 55 ?  controller.stickerListFirstImageOfOD[i].left = 185 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 50 ?  controller.stickerListFirstImageOfOD[i].left = 190 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 45 ?  controller.stickerListFirstImageOfOD[i].left = 195 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 40 ?  controller.stickerListFirstImageOfOD[i].left = 200 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 35 ?  controller.stickerListFirstImageOfOD[i].left = 205 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 30 ?  controller.stickerListFirstImageOfOD[i].left = 210 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 25 ?  controller.stickerListFirstImageOfOD[i].left = 215 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 20 ?  controller.stickerListFirstImageOfOD[i].left = 220 :
                                  controller.stickerListFirstImageOfOD[i].left = 230;

                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.stickerListFirstImageOfOD[i].left = 84;
                                  // controller.update();
                                }else{
                                  ScreenUtil().screenWidth >= 430 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-50 :
                                  ScreenUtil().screenWidth >= 410 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-44 :
                                  ScreenUtil().screenWidth >= 390 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-39 :
                                  ScreenUtil().screenWidth >= 375 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-32 :
                                  ScreenUtil().screenWidth >= 360 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-23 :
                                  ScreenUtil().screenWidth >= 340 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-14 :
                                  ScreenUtil().screenWidth >= 320 ? controller.stickerListFirstImageOfOD[i].left =  off.dx-3 :
                                  controller.stickerListFirstImageOfOD[i].left =  off.dx-2 ;
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
                  for(var i=0; i< controller.imageListOfOd.length;i++)
                    Positioned(

                        left: controller.imageListOfOd[i].left,
                        top: controller.imageListOfOd[i].top,
                        child: Tooltip(
                          message: "DoubleTap To Remove",
                          textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                          showDuration: 1.seconds,
                          height: 60.h,
                          child: GestureDetector(
                            onDoubleTap: () {
                              controller.removeImageIndexOfOd = i;
                              controller.update();
                              controller.removeImageOfOd();
                            },
                            onTap: (){
                              controller.imageSelected = true;
                              controller.currentIndexOfImage = i;
                              controller.update();
                            },

                            child: Draggable(
                              feedback:   controller.imageListOfOd[i].imageUrl != null ? Container(
                                height: controller.imageListOfOd[i].imageHeight,
                                width: controller.imageListOfOd[i].imageWeight,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: NetworkImage(controller.imageListOfOd[i].imageUrl!),fit: BoxFit.fill)),
                              ) :  controller.imageListOfOd[i].image != null ?  Container(
                                height: controller.imageListOfOd[i].imageHeight,
                                width: controller.imageListOfOd[i].imageWeight,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: FileImage(controller.imageListOfOd[i].image!),fit: BoxFit.fill)),
                              ) : Container(),


                              child: controller.imageListOfOd[i].imageUrl != null ? Container(
                                height: controller.imageListOfOd[i].imageHeight,
                                width: controller.imageListOfOd[i].imageWeight,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: NetworkImage(controller.imageListOfOd[i].imageUrl!),fit: BoxFit.fill)),
                              ) :  controller.imageListOfOd[i].image != null ?  Container(
                                height: controller.imageListOfOd[i].imageHeight,
                                width: controller.imageListOfOd[i].imageWeight,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: FileImage(controller.imageListOfOd[i].image!),fit: BoxFit.fill)),
                              ) : Container(),

                              onDragEnd: (drag) {
                                final renderBox = context.findRenderObject() as RenderBox;
                                Offset off = renderBox.globalToLocal(drag.offset);

                                if(
                                controller.imageListOfOd[i].imageHeight! >= 50 ? off.dy > 400 :
                                controller.imageListOfOd[i].imageHeight! >= 70 ? off.dy > 360 :
                                controller.imageListOfOd[i].imageHeight! >= 90 ? off.dy > 320 :
                                controller.imageListOfOd[i].imageHeight! >= 110 ? off.dy > 300 :
                                controller.imageListOfOd[i].imageHeight! >= 130 ?off.dy > 280  :
                                off.dy > 450
                                )
                                {
                                  controller.imageListOfOd[i].imageHeight! >= 250 ? controller.imageListOfOd[i].top = 79 :
                                  controller.imageListOfOd[i].imageHeight! >= 230 ? controller.imageListOfOd[i].top = 89 :
                                  controller.imageListOfOd[i].imageHeight! >= 210 ? controller.imageListOfOd[i].top = 93 :
                                  controller.imageListOfOd[i].imageHeight! >= 190 ? controller.imageListOfOd[i].top = 106 :
                                  controller.imageListOfOd[i].imageHeight! >= 170 ? controller.imageListOfOd[i].top = 127 :
                                  controller.imageListOfOd[i].imageHeight! >= 150 ? controller.imageListOfOd[i].top = 148 :
                                  controller.imageListOfOd[i].imageHeight! >= 130 ? controller.imageListOfOd[i].top = 169 :
                                  controller.imageListOfOd[i].imageHeight! >= 110 ? controller.imageListOfOd[i].top = 185 :
                                  controller.imageListOfOd[i].imageHeight! >= 90 ? controller.imageListOfOd[i].top = 210 :
                                  controller.imageListOfOd[i].imageHeight! >= 70 ? controller.imageListOfOd[i].top = 230 :
                                  controller.imageListOfOd[i].imageHeight! >= 50 ? controller.imageListOfOd[i].top = 240 :
                                  controller.imageListOfOd[i].top = 256;
                                  print("${controller.imageListOfOd[i].imageHeight!}");
                                  // controller.update();
                                }else if(off.dy < 240){
                                  controller.imageListOfOd[i].top = 80;
                                  // controller.update();
                                }else{
                                  ScreenUtil().screenHeight >= 860 ? controller.imageListOfOd[i].top =  off.dy-207 :
                                  ScreenUtil().screenHeight >= 800 ? controller.imageListOfOd[i].top =  off.dy-200 :
                                  ScreenUtil().screenHeight >= 780 ? controller.imageListOfOd[i].top =  off.dy-195 :

                                  ScreenUtil().screenHeight >= 650 ? controller.imageListOfOd[i].top =  off.dy-178 :
                                  ScreenUtil().screenHeight >= 610 ? controller.imageListOfOd[i].top =  off.dy-175 :

                                  ScreenUtil().screenHeight >= 570 ? controller.imageListOfOd[i].top =  off.dy-167 :
                                  ScreenUtil().screenHeight >= 530 ? controller.imageListOfOd[i].top =  off.dy-165 :
                                  ScreenUtil().screenHeight >= 490 ? controller.imageListOfOd[i].top =  off.dy-160 :
                                  controller.imageListOfOd[i].top =  off.dy-155;

                                  // controller.update();
                                }

                                if(
                                controller.imageListOfOd[i].imageWeight! >= 50 ? off.dx > 235 :
                                controller.imageListOfOd[i].imageWeight! >= 70 ? off.dx > 190 :
                                controller.imageListOfOd[i].imageWeight! >= 90 ? off.dx > 160 :
                                controller.imageListOfOd[i].imageWeight! >= 110 ? off.dx > 125 :
                                controller.imageListOfOd[i].imageWeight! >= 130 ? off.dx > 105 :
                                off.dx > 270
                                )
                                {
                                  controller.imageListOfOd[i].imageWeight! >= 135 ?  controller.imageListOfOd[i].left = 95 :
                                  controller.imageListOfOd[i].imageWeight! >= 130 ?  controller.imageListOfOd[i].left = 100 :
                                  controller.imageListOfOd[i].imageWeight! >= 125 ?  controller.imageListOfOd[i].left = 105 :
                                  controller.imageListOfOd[i].imageWeight! >= 120 ?  controller.imageListOfOd[i].left = 110 :
                                  controller.imageListOfOd[i].imageWeight! >= 115 ?  controller.imageListOfOd[i].left = 120 :
                                  controller.imageListOfOd[i].imageWeight! >= 110 ?  controller.imageListOfOd[i].left = 125 :
                                  controller.imageListOfOd[i].imageWeight! >= 105 ?  controller.imageListOfOd[i].left = 130 :
                                  controller.imageListOfOd[i].imageWeight! >= 100 ?  controller.imageListOfOd[i].left = 135 :
                                  controller.imageListOfOd[i].imageWeight! >= 95 ?  controller.imageListOfOd[i].left = 140 :

                                  controller.imageListOfOd[i].imageWeight! >= 90 ?  controller.imageListOfOd[i].left = 146 :
                                  controller.imageListOfOd[i].imageWeight! >= 86 ?  controller.imageListOfOd[i].left = 152 :
                                  controller.imageListOfOd[i].imageWeight! >= 80 ?  controller.imageListOfOd[i].left = 155 :
                                  controller.imageListOfOd[i].imageWeight! >= 74 ?  controller.imageListOfOd[i].left = 163 :
                                  controller.imageListOfOd[i].imageWeight! >= 68 ?  controller.imageListOfOd[i].left = 168 :
                                  controller.imageListOfOd[i].imageWeight! >= 62 ?  controller.imageListOfOd[i].left = 170 :
                                  controller.imageListOfOd[i].imageWeight! >= 56 ?  controller.imageListOfOd[i].left = 180 :
                                  controller.imageListOfOd[i].imageWeight! >= 50 ?  controller.imageListOfOd[i].left = 185 :
                                  controller.imageListOfOd[i].imageWeight! >= 46 ?  controller.imageListOfOd[i].left = 190 :
                                  controller.imageListOfOd[i].imageWeight! >= 42 ?  controller.imageListOfOd[i].left = 195 :
                                  controller.imageListOfOd[i].imageWeight! >= 38 ?  controller.imageListOfOd[i].left = 200 :
                                  controller.imageListOfOd[i].left = 210;
                                  // controller.imageimageListOfOdList[i].left = 160;
                                  print("${  controller.imageListOfOd[i].imageWeight!}");
                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.imageListOfOd[i].left = 84;
                                  // controller.update();
                                }else{
                                  ScreenUtil().screenWidth >= 430 ? controller.imageListOfOd[i].left =  off.dx-50 :
                                  ScreenUtil().screenWidth >= 410 ? controller.imageListOfOd[i].left =  off.dx-44 :
                                  ScreenUtil().screenWidth >= 390 ? controller.imageListOfOd[i].left =  off.dx-39 :
                                  ScreenUtil().screenWidth >= 375 ? controller.imageListOfOd[i].left =  off.dx-32 :
                                  ScreenUtil().screenWidth >= 360 ? controller.imageListOfOd[i].left =  off.dx-23 :
                                  ScreenUtil().screenWidth >= 340 ? controller.imageListOfOd[i].left =  off.dx-14 :
                                  ScreenUtil().screenWidth >= 320 ? controller.imageListOfOd[i].left =  off.dx-3 :
                                  controller.imageListOfOd[i].left =  off.dx-2 ;
                                  // controller.update();
                                }
                                controller.update();

                              },
                            ),
                          ),
                        )
                    ),
                ],
              )
          ),
        );
      }
  );
}