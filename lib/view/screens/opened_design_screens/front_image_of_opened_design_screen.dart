import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import '../../../controller/create_new_design_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
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
              height: 280,
              width: 700.w,
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

                                if(off.dy > 300 ){
                                  controller.textListOfOd[i].top = 160;
                                  // controller.update();
                                }else if(off.dy < 230){
                                  controller.textListOfOd[i].top = 70;
                                  // controller.update();
                                }else{
                                  controller.textListOfOd[i].top =  off.dy-159;
                                  // controller.update();
                                }

                                if(off.dx > 160 ){
                                  controller.textListOfOd[i].left = 105;
                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.textListOfOd[i].left = 68;
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

                            child: Draggable(
                              feedback:   Container(
                                    height: 150.w,
                                    width: 150.h,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(image: AssetImage("${controller.stickerListFirstImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                                  ),

                              child:   Container(
                                    height: 150.w,
                                    width: 150.h,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(image: AssetImage("${controller.stickerListFirstImageOfOD[i].sticker}"),fit: BoxFit.scaleDown)),
                                  ),


                              onDragEnd: (drag) {
                                // print(drag.offset);
                                final renderBox = context.findRenderObject() as RenderBox;
                                Offset off = renderBox.globalToLocal(drag.offset);

                                if(off.dy > 300 ){
                                  controller.stickerListFirstImageOfOD[i].top = 140;
                                  // controller.update();
                                }else if(off.dy < 210){
                                  controller.stickerListFirstImageOfOD[i].top = 70;
                                  // controller.update();
                                }else{
                                  controller.stickerListFirstImageOfOD[i].top =  off.dy-159;
                                  // controller.update();
                                }


                                if(off.dx > 200 ){
                                  controller.stickerListFirstImageOfOD[i].left = 117;
                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.stickerListFirstImageOfOD[i].left = 65;
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

                            child: Draggable(
                              feedback:   controller.imageListOfOd[i].imageUrl != null ? Container(
                                height: 200.w,
                                width: 200.h,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: NetworkImage(controller.imageListOfOd[i].imageUrl!),fit: BoxFit.fill)),
                              ) :  controller.imageListOfOd[i].image != null ?  Container(
                                height: 200.w,
                                width: 200.h,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: FileImage(controller.imageListOfOd[i].image!),fit: BoxFit.fill)),
                              ) : Container(),


                              child: controller.imageListOfOd[i].imageUrl != null ? Container(
                                height: 200.w,
                                width: 200.h,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: NetworkImage(controller.imageListOfOd[i].imageUrl!),fit: BoxFit.fill)),
                              ) :  controller.imageListOfOd[i].image != null ?  Container(
                                height: 200.w,
                                width: 200.h,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: FileImage(controller.imageListOfOd[i].image!),fit: BoxFit.fill)),
                              ) : Container(),

                              onDragEnd: (drag) {
                                final renderBox = context.findRenderObject() as RenderBox;
                                Offset off = renderBox.globalToLocal(drag.offset);

                                // controller.imageList[i].top = off.dy - 159;
                                // controller.imageList[i].left = off.dx - 60;

                                if(off.dy > 280 ){
                                  controller.imageListOfOd[i].top = 110;
                                  // controller.update();
                                }else if(off.dy < 240){
                                  controller.imageListOfOd[i].top = 75;
                                  // controller.update();
                                }else{
                                  controller.imageListOfOd[i].top =  off.dy-159;
                                  // controller.update();
                                }


                                if(off.dx > 180 ){
                                  controller.imageListOfOd[i].left = 110;
                                  // controller.update();
                                }else if(off.dx < 140){
                                  controller.imageListOfOd[i].left = 55;
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