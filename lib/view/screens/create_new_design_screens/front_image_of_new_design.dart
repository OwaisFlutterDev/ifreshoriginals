import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          height: 360,
          width: 940.w,
          decoration: BoxDecoration(
              color: Colors.transparent,
              // border: Border.all(color: blackColor,width: 1),
              image: DecorationImage(image: AssetImage("${homeController.selectedFrontImage}",),
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
              // Center(
              //   child: Container(
              //     width: 140,
              //       height: 190,
              //       decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
              //     child: Center(child: Text(".")),
              //   ),
              // ),

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
                          feedback:  Text(
                            "${controller.textList[i].text}",
                            style: GoogleFonts.getFont('${controller.textList[i].fontFamily}' , textStyle: TextStyle(
                               color: Color(controller.textList[i].color ?? blackHexColor)  , fontStyle: controller.textList[i].fontStyle,
                               fontSize: controller.textList[i].fontSize, fontWeight: controller.textList[i].fontWeight
                            )), textAlign: controller.textList[i].textAlign
                          ),

                          child: Text("${controller.textList[i].text}",
                            style: GoogleFonts.getFont('${controller.textList[i].fontFamily}' , textStyle: TextStyle(
                                color: Color(controller.textList[i].color ?? blackHexColor), fontStyle: controller.textList[i].fontStyle,
                                fontSize: controller.textList[i].fontSize , fontWeight: controller.textList[i].fontWeight,
                            ), ), textAlign: controller.textList[i].textAlign ,
                          ),

                          onDragEnd: (drag) {

                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.textList[i].top = off.dy - 159;
                            // controller.textList[i].left = off.dx - 60;


                            if(off.dy > 400 ){
                              controller.textList[i].top = 243;
                              // controller.update();
                            }else if(off.dy < 230){
                              controller.textList[i].top = 80;
                              // controller.update();
                            }else{
                              controller.textList[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if(
                              controller.textList[i].fontSize! >= 10 ? off.dx > 235 :
                              controller.textList[i].fontSize! >= 20 ? off.dx > 190 :
                              controller.textList[i].fontSize! >= 30 ? off.dx > 160 :
                              controller.textList[i].fontSize! >= 40 ? off.dx > 125 :
                              controller.textList[i].fontSize! >= 50 ? off.dx > 105 :
                              off.dx > 270
                            )
                            {
                              controller.textList[i].fontSize! >= 55 ?  controller.textList[i].left = 75 :
                              controller.textList[i].fontSize! >= 40 ?  controller.textList[i].left = 100 :
                              controller.textList[i].fontSize! >= 30 ?  controller.textList[i].left = 142 :
                              controller.textList[i].fontSize! >= 20 ?  controller.textList[i].left = 155 :
                              controller.textList[i].fontSize! >= 10 ?  controller.textList[i].left = 175 :
                              controller.textList[i].left = 200;
                            // controller.imageList[i].left = 160;
                            print("${  controller.textList[i].fontSize!}");

                            }else if(off.dx < 140){
                              controller.textList[i].left = 84;
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
                        onTap: (){
                          controller.stickerSelected = true;
                          controller.currentIndexOfSticker = i;
                          controller.update();
                        },

                        child: Draggable(
                          feedback:   Container(
                            height: controller.stickerList[i].stickerHeight,
                            width: controller.stickerList[i].stickerWeight,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: AssetImage("${controller.stickerList[i].sticker}"),fit: BoxFit.scaleDown,)),
                          ),

                          child:   Container(
                            height: controller.stickerList[i].stickerHeight,
                            width: controller.stickerList[i].stickerWeight,
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

                            if(
                            controller.stickerList[i].stickerHeight! >= 50 ? off.dy > 400 :
                            controller.stickerList[i].stickerHeight! >= 70 ? off.dy > 360 :
                            controller.stickerList[i].stickerHeight! >= 90 ? off.dy > 320 :
                            controller.stickerList[i].stickerHeight! >= 110 ? off.dy > 300 :
                            off.dy > 450
                            )
                            {
                              controller.stickerList[i].stickerHeight! >= 110 ? controller.stickerList[i].top = 170 :
                              controller.stickerList[i].stickerHeight! >= 90 ? controller.stickerList[i].top = 190 :
                              controller.stickerList[i].stickerHeight! >= 70 ? controller.stickerList[i].top = 210 :
                              controller.stickerList[i].stickerHeight! >= 50 ? controller.stickerList[i].top = 230 :
                              controller.stickerList[i].top = 256;
                              // controller.update();
                              print("${controller.stickerList[i].stickerHeight!}");
                            }else if(off.dy < 230){
                              controller.stickerList[i].top = 80;
                              // controller.update();
                            }else{
                              controller.stickerList[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if( controller.stickerList[i].stickerWeight! >= 50 ? off.dx > 235 :
                                controller.stickerList[i].stickerWeight! >= 70 ? off.dx > 205 :
                                controller.stickerList[i].stickerWeight! >= 90 ? off.dx > 180 :
                                controller.stickerList[i].stickerWeight! >= 110 ? off.dx > 145 :
                                off.dx > 270
                            )
                            {
                              controller.stickerList[i].stickerWeight! >= 110 ?  controller.stickerList[i].left = 116 :
                              controller.stickerList[i].stickerWeight! >= 90 ?  controller.stickerList[i].left = 140 :
                              controller.stickerList[i].stickerWeight! >= 70 ?  controller.stickerList[i].left = 155 :
                              controller.stickerList[i].stickerWeight! >= 50 ?  controller.stickerList[i].left = 176 :
                              controller.stickerList[i].left = 200;
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.stickerList[i].left = 84;
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
                        onTap: (){
                          controller.imageSelected = true;
                          controller.currentIndexOfImage = i;
                          controller.update();
                        },

                        child: Draggable(
                          feedback:   controller.imageList[i].image == null ? Container() :  Container(
                            height: controller.imageList[i].imageHeight,
                            width: controller.imageList[i].imageWeight,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(image: FileImage(controller.imageList[i].image!),fit: BoxFit.fill)),
                          ),


                          child: controller.imageList[i].image == null ? Container() : Container(
                            height: controller.imageList[i].imageHeight,
                            width: controller.imageList[i].imageWeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: FileImage(controller.imageList[i].image! ),fit: BoxFit.fill),
                                color: Colors.transparent),
                          ),

                          onDragEnd: (drag) {
                            final renderBox = context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);

                            // controller.imageList[i].top = off.dy - 159;
                            // controller.imageList[i].left = off.dx - 60;

                            if(
                            controller.imageList[i].imageHeight! >= 50 ? off.dy > 400 :
                            controller.imageList[i].imageHeight! >= 70 ? off.dy > 360 :
                            controller.imageList[i].imageHeight! >= 90 ? off.dy > 320 :
                            controller.imageList[i].imageHeight! >= 110 ? off.dy > 300 :
                            controller.imageList[i].imageHeight! >= 130 ?off.dy > 280  :
                            off.dy > 450
                            )
                            {
                              controller.imageList[i].imageHeight! >= 130 ? controller.imageList[i].top = 160 :
                              controller.imageList[i].imageHeight! >= 110 ? controller.imageList[i].top = 185 :
                              controller.imageList[i].imageHeight! >= 90 ? controller.imageList[i].top = 210 :
                              controller.imageList[i].imageHeight! >= 70 ? controller.imageList[i].top = 230 :
                              controller.imageList[i].imageHeight! >= 50 ? controller.imageList[i].top = 240 :
                              controller.imageList[i].top = 256;
                              print("${controller.imageList[i].imageHeight!}");
                              // controller.update();
                            }else if(off.dy < 240){
                              controller.imageList[i].top = 80;
                              // controller.update();
                            }else{
                              controller.imageList[i].top =  off.dy-159;
                              // controller.update();
                            }

                            if(
                            controller.imageList[i].imageWeight! >= 50 ? off.dx > 235 :
                            controller.imageList[i].imageWeight! >= 70 ? off.dx > 190 :
                            controller.imageList[i].imageWeight! >= 90 ? off.dx > 160 :
                            controller.imageList[i].imageWeight! >= 110 ? off.dx > 125 :
                            controller.imageList[i].imageWeight! >= 130 ? off.dx > 105 :
                            off.dx > 270
                            )
                            {
                              controller.imageList[i].imageWeight! >= 130 ?  controller.imageList[i].left = 95 :
                              controller.imageList[i].imageWeight! >= 110 ?  controller.imageList[i].left = 116 :
                              controller.imageList[i].imageWeight! >= 90 ?  controller.imageList[i].left = 140 :
                              controller.imageList[i].imageWeight! >= 70 ?  controller.imageList[i].left = 155 :
                              controller.imageList[i].imageWeight! >= 50 ?  controller.imageList[i].left = 176 :
                              controller.imageList[i].left = 195;
                              // controller.imageList[i].left = 160;
                              print("${  controller.imageList[i].imageWeight!}");
                              // controller.update();
                            }else if(off.dx < 140){
                              controller.imageList[i].left = 84;
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
            ],
          )
        ),
      );
    }
  );
}