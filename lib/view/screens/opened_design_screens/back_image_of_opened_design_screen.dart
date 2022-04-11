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
            height: 280,
            width: 700.w,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // border: Border.all(color: blackColor,width: 1),
                image: DecorationImage(image: AssetImage("${homeController.selectedBackImageOfOpenedDesign}",),
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

                              if(off.dy > 300 ){
                                controller.textListForSecondImageOfOd[i].top = 160;
                                // controller.update();
                              }else if(off.dy < 230){
                                controller.textListForSecondImageOfOd[i].top = 70;
                                // controller.update();
                              }else{
                                controller.textListForSecondImageOfOd[i].top =  off.dy-159;
                                // controller.update();
                              }

                              if(off.dx > 160 ){
                                controller.textListForSecondImageOfOd[i].left = 105;
                                // controller.update();
                              }else if(off.dx < 140){
                                controller.textListForSecondImageOfOd[i].left = 68;
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
                            controller.update();
                            controller.removeStickerSecondImageOfOD();
                          },

                          child: Draggable(
                            feedback:   Container(
                              height: 150.w,
                              width: 150.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image: AssetImage("${controller.stickerListSecondImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                            ),

                            child:   Container(
                              height: 150.w,
                              width: 150.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image: AssetImage("${controller.stickerListSecondImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
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
                                controller.stickerListSecondImageOfOD[i].top = 140;
                                // controller.update();
                              }else if(off.dy < 210){
                                controller.stickerListSecondImageOfOD[i].top = 70;
                                // controller.update();
                              }else{
                                controller.stickerListSecondImageOfOD[i].top =  off.dy-159;
                                // controller.update();
                              }


                              if(off.dx > 200 ){
                                controller.stickerListSecondImageOfOD[i].left = 117;
                                // controller.update();
                              }else if(off.dx < 140){
                                controller.stickerListSecondImageOfOD[i].left = 65;
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

                          child: Draggable(
                            feedback:   controller.imageListSecondImageOfOd[i].imageUrl != null ? Container(
                              height: 200.w,
                              width: 200.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  NetworkImage(controller.imageListSecondImageOfOd[i].imageUrl!),fit: BoxFit.fill)),
                            ) :  controller.imageListSecondImageOfOd[i].image != null ?  Container(
                              height: 200.w,
                              width: 200.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  FileImage(controller.imageListSecondImageOfOd[i].image!),fit: BoxFit.fill)),
                            ) : Container(),


                            child: controller.imageListSecondImageOfOd[i].imageUrl != null ? Container(
                              height: 200.w,
                              width: 200.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  NetworkImage(controller.imageListSecondImageOfOd[i].imageUrl!),fit: BoxFit.fill)),
                            ) :  controller.imageListSecondImageOfOd[i].image != null ?  Container(
                              height: 200.w,
                              width: 200.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image:  FileImage(controller.imageListSecondImageOfOd[i].image!),fit: BoxFit.fill)),
                            ) : Container(),

                            onDragEnd: (drag) {
                              final renderBox = context.findRenderObject() as RenderBox;
                              Offset off = renderBox.globalToLocal(drag.offset);

                              // controller.imageList[i].top = off.dy - 159;
                              // controller.imageList[i].left = off.dx - 60;

                              if(off.dy > 280 ){
                                controller.imageListSecondImageOfOd[i].top = 110;
                                // controller.update();
                              }else if(off.dy < 240){
                                controller.imageListSecondImageOfOd[i].top = 75;
                                // controller.update();
                              }else{
                                controller.imageListSecondImageOfOd[i].top =  off.dy-159;
                                // controller.update();
                              }


                              if(off.dx > 180 ){
                                controller.imageListSecondImageOfOd[i].left = 110;
                                // controller.update();
                              }else if(off.dx < 140){
                                controller.imageListSecondImageOfOd[i].left = 55;
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