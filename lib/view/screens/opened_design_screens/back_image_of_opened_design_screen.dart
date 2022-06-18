import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import '../../../constant/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';

Widget backImageOfOpenedDesign(context) {

  FunctionalityOnOpenedDesignController functionalityOnImageController = Get.put(FunctionalityOnOpenedDesignController());
  HomeController homeController = Get.put(HomeController());

  return GetBuilder<OpenedDesignController>(
      init: OpenedDesignController(),
      builder: (controller) {
        return RepaintBoundary(
          key: functionalityOnImageController.backGlobalKeyOfOD,
          child: Container(
            height: 360,
            width: 320,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // border: Border.all(color: blackColor,width: 1),
                image: DecorationImage(image: CachedNetworkImageProvider("${homeController.selectedBackImageOfOpenedDesign}",),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(controller.convertedColorForSecondShirt ?? whiteColor, BlendMode.modulate)
                )
            ),
            child:
            Stack(
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
                for(var i=0; i< controller.textListForSecondImageOfOd.length;i++)
                  Positioned(

                      left: controller.textListForSecondImageOfOd[i].left,
                      top: controller.textListForSecondImageOfOd[i].top,
                      child: Tooltip(
                        message: "DoubleTap To Remove",
                        textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                        showDuration: 1.seconds,
                        height: 60.h,
                        child: GestureDetector(
                          onDoubleTap: () {
                            controller.removeTextIndexSecondImageOfOd = i;
                            controller.update();
                            controller.removeTextSecondImageOfOd();
                          },
                          onTap: (){
                            controller.textSelectedOfOd = true;
                            controller.currentIndexOfTextSecondImageOfOd = i;
                            controller.update();
                          },

                          child: Draggable(
                            feedback: Text("${controller.textListForSecondImageOfOd[i].text}",
                              style: GoogleFonts.getFont('${controller.textListForSecondImageOfOd[i].fontFamily}' , textStyle: TextStyle(
                                  color: Color(controller.textListForSecondImageOfOd[i].color ?? blackHexColor), fontStyle: controller.textListForSecondImageOfOd[i].fontStyle,
                                  fontSize: controller.textListForSecondImageOfOd[i].fontSize, fontWeight: controller.textListForSecondImageOfOd[i].fontWeight
                              )),
                            ),
                            child: Text("${controller.textListForSecondImageOfOd[i].text}",
                              style: GoogleFonts.getFont('${controller.textListForSecondImageOfOd[i].fontFamily}' , textStyle: TextStyle(
                                  color: Color(controller.textListForSecondImageOfOd[i].color ?? blackHexColor), fontStyle: controller.textListForSecondImageOfOd[i].fontStyle,
                                  fontSize: controller.textListForSecondImageOfOd[i].fontSize, fontWeight: controller.textListForSecondImageOfOd[i].fontWeight
                              )),
                            ),

                            onDragEnd: (drag) {

                              final renderBox = context.findRenderObject() as RenderBox;
                              Offset off = renderBox.globalToLocal(drag.offset);

                              // controller.textList[i].top = off.dy - 159;
                              // controller.textList[i].left = off.dx - 60;

                              if(off.dy > 400 ){
                                controller.textListForSecondImageOfOd[i].top = 243;
                                // controller.update();
                              }else if(off.dy < 230){
                                controller.textListForSecondImageOfOd[i].top = 80;
                                // controller.update();
                              }else{
                                controller.textListForSecondImageOfOd[i].top =  off.dy-159;
                                // controller.update();
                              }

                              if(
                              controller.textListForSecondImageOfOd[i].fontSize! >= 10 ? off.dx > 235 :
                              controller.textListForSecondImageOfOd[i].fontSize! >= 20 ? off.dx > 190 :
                              controller.textListForSecondImageOfOd[i].fontSize! >= 30 ? off.dx > 160 :
                              controller.textListForSecondImageOfOd[i].fontSize! >= 40 ? off.dx > 125 :
                              controller.textListForSecondImageOfOd[i].fontSize! >= 50 ? off.dx > 105 :
                              off.dx > 270
                              )
                              {
                                controller.textListForSecondImageOfOd[i].fontSize! >= 55 ?  controller.textListForSecondImageOfOd[i].left = 75 :
                                controller.textListForSecondImageOfOd[i].fontSize! >= 40 ?  controller.textListForSecondImageOfOd[i].left = 100 :
                                controller.textListForSecondImageOfOd[i].fontSize! >= 30 ?  controller.textListForSecondImageOfOd[i].left = 142 :
                                controller.textListForSecondImageOfOd[i].fontSize! >= 20 ?  controller.textListForSecondImageOfOd[i].left = 155 :
                                controller.textListForSecondImageOfOd[i].fontSize! >= 10 ?  controller.textListForSecondImageOfOd[i].left = 175 :
                                controller.textListForSecondImageOfOd[i].left = 200;
                                // controller.imageList[i].left = 160;
                                print("${  controller.textListForSecondImageOfOd[i].fontSize!}");

                              }else if(off.dx < 140){
                                controller.textListForSecondImageOfOd[i].left = 84;
                                // controller.update();
                              }else{
                                controller.textListForSecondImageOfOd[i].left =  off.dx-60;
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
                for(var i=0; i< controller.stickerListSecondImageOfOD.length;i++)
                  Positioned(

                      left: controller.stickerListSecondImageOfOD[i].left,
                      top: controller.stickerListSecondImageOfOD[i].top,
                      child: Tooltip(
                        message: "DoubleTap To Remove",
                        textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                        showDuration: 1.seconds,
                        height: 60.h,
                        child: GestureDetector(
                          onDoubleTap: () {
                            controller.removeStickerIndexSecondImageOfOD  = i;
                            // controller.subStickerPrice =  controller.stickerListSecondImageOfOD[i].stickerPrice!;
                            controller.update();
                            controller.removeStickerSecondImageOfOD();
                          },
                          onTap: (){
                            controller.stickerSelected = true;
                            controller.currentIndexOfStickerOfSecImage = i;
                            controller.update();
                          },

                          child: Draggable(
                            feedback:   Container(
                              height: controller.stickerListSecondImageOfOD[i].stickerHeight,
                              width: controller.stickerListSecondImageOfOD[i].stickerWeight,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image: CachedNetworkImageProvider("${controller.stickerListSecondImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                            ),

                            child:   Container(
                              height: controller.stickerListSecondImageOfOD[i].stickerHeight,
                              width: controller.stickerListSecondImageOfOD[i].stickerWeight,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image: CachedNetworkImageProvider("${controller.stickerListSecondImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
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
                              controller.stickerListSecondImageOfOD[i].stickerHeight! >= 50 ? off.dy > 400 :
                              controller.stickerListSecondImageOfOD[i].stickerHeight! >= 70 ? off.dy > 360 :
                              controller.stickerListSecondImageOfOD[i].stickerHeight! >= 90 ? off.dy > 320 :
                              controller.stickerListSecondImageOfOD[i].stickerHeight! >= 110 ? off.dy > 300 :
                              off.dy > 450
                              )
                              {
                                controller.stickerListSecondImageOfOD[i].stickerHeight! >= 110 ? controller.stickerListSecondImageOfOD[i].top = 170 :
                                controller.stickerListSecondImageOfOD[i].stickerHeight! >= 90 ? controller.stickerListSecondImageOfOD[i].top = 190 :
                                controller.stickerListSecondImageOfOD[i].stickerHeight! >= 70 ? controller.stickerListSecondImageOfOD[i].top = 210 :
                                controller.stickerListSecondImageOfOD[i].stickerHeight! >= 50 ? controller.stickerListSecondImageOfOD[i].top = 230 :
                                controller.stickerListSecondImageOfOD[i].top = 256;
                                // controller.update();
                                print("${controller.stickerListSecondImageOfOD[i].stickerHeight!}");
                              }else if(off.dy < 230){
                                controller.stickerListSecondImageOfOD[i].top = 80;
                                // controller.update();
                              }else{
                                controller.stickerListSecondImageOfOD[i].top =  off.dy-159;
                                // controller.update();
                              }

                              if( controller.stickerListSecondImageOfOD[i].stickerWeight! >= 50 ? off.dx > 235 :
                              controller.stickerListSecondImageOfOD[i].stickerWeight! >= 70 ? off.dx > 205 :
                              controller.stickerListSecondImageOfOD[i].stickerWeight! >= 90 ? off.dx > 180 :
                              controller.stickerListSecondImageOfOD[i].stickerWeight! >= 110 ? off.dx > 145 :
                              off.dx > 270
                              )
                              {
                                controller.stickerListSecondImageOfOD[i].stickerWeight! >= 110 ?  controller.stickerListSecondImageOfOD[i].left = 116 :
                                controller.stickerListSecondImageOfOD[i].stickerWeight! >= 90 ?  controller.stickerListSecondImageOfOD[i].left = 140 :
                                controller.stickerListSecondImageOfOD[i].stickerWeight! >= 70 ?  controller.stickerListSecondImageOfOD[i].left = 155 :
                                controller.stickerListSecondImageOfOD[i].stickerWeight! >= 50 ?  controller.stickerListSecondImageOfOD[i].left = 176 :
                                controller.stickerListSecondImageOfOD[i].left = 200;
                                // controller.update();
                              }else if(off.dx < 140){
                                controller.stickerListSecondImageOfOD[i].left = 84;
                                // controller.update();
                              }else{
                                controller.stickerListSecondImageOfOD[i].left =  off.dx-60;
                                // controller.update();
                              }
                              controller.update();
                            },
                          ),
                        ),
                      )
                  ),

                // //-----------------------------------------------
                // //---------- =======  Cam or Gallery Image  ======= ----------
                // //-----------------------------------------------
                for(var i=0; i< controller.imageListSecondImageOfOd.length;i++)
                  Positioned(

                      left: controller.imageListSecondImageOfOd[i].left,
                      top: controller.imageListSecondImageOfOd[i].top,
                      child: Tooltip(
                        message: "DoubleTap To Remove",
                        textStyle: TextStyle(fontSize: 30.sp,color: whiteColor),
                        showDuration: 1.seconds,
                        height: 60.h,
                        child: GestureDetector(
                          onDoubleTap: () {
                            controller.removeImageIndexSecondImageOfOd = i;
                            controller.update();
                            controller.removeImageSecondImageOfOd();
                          },
                          onTap: (){
                            controller.imageSelected = true;
                            controller.currentIndexOfImageOfSI = i;
                            controller.update();
                          },

                          child: Draggable(
                            feedback:   controller.imageListSecondImageOfOd[i].imageUrl != null ? Container(
                              height: controller.imageListSecondImageOfOd[i].imageHeight,
                              width: controller.imageListSecondImageOfOd[i].imageWeight,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  NetworkImage(controller.imageListSecondImageOfOd[i].imageUrl!),fit: BoxFit.fill)),
                            ) :  controller.imageListSecondImageOfOd[i].image != null ?  Container(
                              height: controller.imageListSecondImageOfOd[i].imageHeight,
                              width: controller.imageListSecondImageOfOd[i].imageWeight,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  FileImage(controller.imageListSecondImageOfOd[i].image!),fit: BoxFit.fill)),
                            ) : Container(),


                            child: controller.imageListSecondImageOfOd[i].imageUrl != null ? Container(
                              height: controller.imageListSecondImageOfOd[i].imageHeight,
                              width: controller.imageListSecondImageOfOd[i].imageWeight,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  NetworkImage(controller.imageListSecondImageOfOd[i].imageUrl!),fit: BoxFit.fill)),
                            ) :  controller.imageListSecondImageOfOd[i].image != null ?  Container(
                              height: controller.imageListSecondImageOfOd[i].imageHeight,
                              width: controller.imageListSecondImageOfOd[i].imageWeight,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  FileImage(controller.imageListSecondImageOfOd[i].image!),fit: BoxFit.fill)),
                            ) : Container(),

                            onDragEnd: (drag) {
                              final renderBox = context.findRenderObject() as RenderBox;
                              Offset off = renderBox.globalToLocal(drag.offset);

                              // controller.imageList[i].top = off.dy - 159;
                              // controller.imageList[i].left = off.dx - 60;

                              if(
                              controller.imageListSecondImageOfOd[i].imageHeight! >= 50 ? off.dy > 400 :
                              controller.imageListSecondImageOfOd[i].imageHeight! >= 70 ? off.dy > 360 :
                              controller.imageListSecondImageOfOd[i].imageHeight! >= 90 ? off.dy > 320 :
                              controller.imageListSecondImageOfOd[i].imageHeight! >= 110 ? off.dy > 300 :
                              controller.imageListSecondImageOfOd[i].imageHeight! >= 130 ?off.dy > 280  :
                              off.dy > 450
                              )
                              {
                                controller.imageListSecondImageOfOd[i].imageHeight! >= 130 ? controller.imageListSecondImageOfOd[i].top = 160 :
                                controller.imageListSecondImageOfOd[i].imageHeight! >= 110 ? controller.imageListSecondImageOfOd[i].top = 185 :
                                controller.imageListSecondImageOfOd[i].imageHeight! >= 90 ? controller.imageListSecondImageOfOd[i].top = 210 :
                                controller.imageListSecondImageOfOd[i].imageHeight! >= 70 ? controller.imageListSecondImageOfOd[i].top = 230 :
                                controller.imageListSecondImageOfOd[i].imageHeight! >= 50 ? controller.imageListSecondImageOfOd[i].top = 240 :
                                controller.imageListSecondImageOfOd[i].top = 256;
                                print("${controller.imageListSecondImageOfOd[i].imageHeight!}");
                                // controller.update();
                              }else if(off.dy < 240){
                                controller.imageListSecondImageOfOd[i].top = 80;
                                // controller.update();
                              }else{
                                controller.imageListSecondImageOfOd[i].top =  off.dy-159;
                                // controller.update();
                              }

                              if(
                              controller.imageListSecondImageOfOd[i].imageWeight! >= 50 ? off.dx > 235 :
                              controller.imageListSecondImageOfOd[i].imageWeight! >= 70 ? off.dx > 190 :
                              controller.imageListSecondImageOfOd[i].imageWeight! >= 90 ? off.dx > 160 :
                              controller.imageListSecondImageOfOd[i].imageWeight! >= 110 ? off.dx > 125 :
                              controller.imageListSecondImageOfOd[i].imageWeight! >= 130 ? off.dx > 105 :
                              off.dx > 270
                              )
                              {
                                controller.imageListSecondImageOfOd[i].imageWeight! >= 130 ?  controller.imageListSecondImageOfOd[i].left = 95 :
                                controller.imageListSecondImageOfOd[i].imageWeight! >= 110 ?  controller.imageListSecondImageOfOd[i].left = 116 :
                                controller.imageListSecondImageOfOd[i].imageWeight! >= 90 ?  controller.imageListSecondImageOfOd[i].left = 140 :
                                controller.imageListSecondImageOfOd[i].imageWeight! >= 70 ?  controller.imageListSecondImageOfOd[i].left = 155 :
                                controller.imageListSecondImageOfOd[i].imageWeight! >= 50 ?  controller.imageListSecondImageOfOd[i].left = 176 :
                                controller.imageListSecondImageOfOd[i].left = 195;
                                // controller.imageList[i].left = 160;
                                print("${  controller.imageListSecondImageOfOd[i].imageWeight!}");
                                // controller.update();
                              }else if(off.dx < 140){
                                controller.imageListSecondImageOfOd[i].left = 84;
                                // controller.update();
                              }else{
                                controller.imageListSecondImageOfOd[i].left =  off.dx-60;
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