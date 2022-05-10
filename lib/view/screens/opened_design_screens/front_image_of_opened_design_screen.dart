import 'package:flutter/cupertino.dart';
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
              width: 940.w,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  // border: Border.all(color: blackColor,width: 1),
                  image: DecorationImage(image: AssetImage("${homeController.selectedFrontImageOfOpenedDesign}",),
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
                                  controller.textListOfOd[i].top =  off.dy-159;
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
                                  controller.textListOfOd[i].fontSize! >= 55 ?  controller.textListOfOd[i].left = 75 :
                                  controller.textListOfOd[i].fontSize! >= 40 ?  controller.textListOfOd[i].left = 100 :
                                  controller.textListOfOd[i].fontSize! >= 30 ?  controller.textListOfOd[i].left = 142 :
                                  controller.textListOfOd[i].fontSize! >= 20 ?  controller.textListOfOd[i].left = 155 :
                                  controller.textListOfOd[i].fontSize! >= 10 ?  controller.textListOfOd[i].left = 175 :
                                  controller.textListOfOd[i].left = 200;
                                  // controller.imageList[i].left = 160;
                                  print("${  controller.textListOfOd[i].fontSize!}");

                                }else if(off.dx < 140){
                                  controller.textListOfOd[i].left = 84;
                                  // controller.update();
                                }else{
                                  controller.textListOfOd[i].left =  off.dx-60;
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
                                        image: DecorationImage(image: AssetImage("${controller.stickerListFirstImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                                  ),

                              child:   Container(
                                height: controller.stickerListFirstImageOfOD[i].stickerHeight,
                                width: controller.stickerListFirstImageOfOD[i].stickerWeight,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(image: AssetImage("${controller.stickerListFirstImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
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
                                  controller.stickerListFirstImageOfOD[i].top =  off.dy-159;
                                  // controller.update();
                                }

                                if( controller.stickerListFirstImageOfOD[i].stickerWeight! >= 50 ? off.dx > 235 :
                                controller.stickerListFirstImageOfOD[i].stickerWeight! >= 70 ? off.dx > 205 :
                                controller.stickerListFirstImageOfOD[i].stickerWeight! >= 90 ? off.dx > 180 :
                                controller.stickerListFirstImageOfOD[i].stickerWeight! >= 110 ? off.dx > 145 :
                                off.dx > 270
                                )
                                {
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 110 ?  controller.stickerListFirstImageOfOD[i].left = 116 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 90 ?  controller.stickerListFirstImageOfOD[i].left = 140 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 70 ?  controller.stickerListFirstImageOfOD[i].left = 155 :
                                  controller.stickerListFirstImageOfOD[i].stickerWeight! >= 50 ?  controller.stickerListFirstImageOfOD[i].left = 176 :
                                  controller.stickerListFirstImageOfOD[i].left = 200;
                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.stickerListFirstImageOfOD[i].left = 84;
                                  // controller.update();
                                }else{
                                  controller.stickerListFirstImageOfOD[i].left =  off.dx-60;
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
                                  controller.imageListOfOd[i].imageHeight! >= 130 ? controller.imageListOfOd[i].top = 160 :
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
                                  controller.imageListOfOd[i].top =  off.dy-159;
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
                                  controller.imageListOfOd[i].imageWeight! >= 130 ?  controller.imageListOfOd[i].left = 95 :
                                  controller.imageListOfOd[i].imageWeight! >= 110 ?  controller.imageListOfOd[i].left = 116 :
                                  controller.imageListOfOd[i].imageWeight! >= 90 ?  controller.imageListOfOd[i].left = 140 :
                                  controller.imageListOfOd[i].imageWeight! >= 70 ?  controller.imageListOfOd[i].left = 155 :
                                  controller.imageListOfOd[i].imageWeight! >= 50 ?  controller.imageListOfOd[i].left = 176 :
                                  controller.imageListOfOd[i].left = 195;
                                  // controller.imageimageListOfOdList[i].left = 160;
                                  print("${  controller.imageListOfOd[i].imageWeight!}");
                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.imageListOfOd[i].left = 84;
                                  // controller.update();
                                }else{
                                  controller.imageListOfOd[i].left =  off.dx-60;
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