import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

AlertDialog textGenerateAlertDialogWidget() {
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
            return GetBuilder<CreateNewDesignController>(
              init: CreateNewDesignController(),
              builder: (controller) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // --- === title cross button === ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          SizedBox(width: 20.w,),
                          largeText(title: "Add Text",color: blackColor,fontWeight: FontWeight.bold),
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
                      // --- === text field for add text === ---
                      SizedBox(height: 60.h,),
                      TextFormField(
                        controller: controller.textController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Add Text",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.r),
                              borderSide: BorderSide(
                                color: Colors.black87,),
                            )
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10.h,),
                      // --- ===  === ---
                     Container(
                              height: 730.h,
                              width: 1.sw,
                              color: Colors.transparent,
                              child: ScrollNavigation(
                                showIdentifier: false,
                                bodyStyle: NavigationBodyStyle(
                                  background: bgColor,
                                  // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                                ),
                                barStyle: NavigationBarStyle(
                                  position: NavigationPosition.top,
                                  background: bgColor,
                                  elevation: 0.0,
                                ),
                                pages: [
                                  // -------- === colors buttons === --------
                                  Container(
                                    width: 0.9.sw,
                                    color: Colors.transparent,
                                    // color: Colors.blue[100]
                                    child: GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                          // maxCrossAxisExtent: 400.h,
                                          crossAxisCount: 4,
                                          mainAxisExtent: 190.h,
                                        ),
                                        itemCount: controller.colorsList.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return  InkWell(
                                              onTap: () {
                                                controller.color = controller.colorsList[index].color;
                                                controller.selectedIndexOfColor = index;
                                                controller.update();
                                              },
                                              child: Container(
                                                height: 170.w,
                                                width: 150.h,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: controller.selectedIndexOfColor == index ? Border.all(color: redColor,width: 1) : Border.all(color: Colors.transparent,width: 1),
                                                    borderRadius: controller.selectedIndexOfColor == index ? BorderRadius.circular(20.r) : BorderRadius.circular(0.r),
                                                    image: DecorationImage(image: AssetImage("${controller.colorsList[index].image}"),fit: BoxFit.scaleDown)),
                                              )

                                          );
                                        }),
                                  ),

                                  // -------- === text font buttons === --------
                                  Container(
                                    width: 0.9.sw,
                                    color: Colors.transparent,
                                    // color: Colors.blue[100]
                                    child: GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                          // maxCrossAxisExtent: 400.h,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 180.h,
                                        ),
                                        itemCount: controller.fontFamilyList.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return  Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: InkWell(
                                                onTap: () {
                                                  controller.fontFamily = controller.fontFamilyList[index].name;
                                                  controller.selectedIndexOfFont = index;
                                                  controller.update();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    border: controller.selectedIndexOfFont == index ? Border.all(color: redColor,width: 1) : Border.all(color: Colors.transparent,width: 1),
                                                    borderRadius:  BorderRadius.circular(27.r) ,


                                                    boxShadow: const <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 4.0,
                                                        offset: Offset(0, 5,),
                                                      )
                                                    ],

                                                  ),
                                                  height: 170.h,
                                                  // width: 80.w,
                                                  child: Align(
                                                      alignment: Alignment.center,
                                                      child: Wrap(
                                                        children: [
                                                          Text("${controller.fontFamilyList[index].name} " ,
                                                          style: GoogleFonts.getFont('${controller.fontFamilyList[index].name}', textStyle: TextStyle(
                                                              color: Colors.black87, fontSize: 34.sp
                                                                   )),
                                                          ),
                                                        ],
                                                      )),
                                                ),

                                            ),
                                          );
                                        }),
                                  ),

                                ],
                                items:  [
                                  ScrollNavigationItem(icon: Column(
                                    children: [
                                      imageWidget(
                                          image: "assets/Asset 65.png",
                                          height: 150.h,
                                          width: 180.w
                                      ),
                                      smallText(title: "Colors")
                                    ],
                                  ),),
                                  ScrollNavigationItem(icon: Column(
                                    children: [
                                      imageWidget(
                                          image: "assets/Asset 66.png",
                                          height: 150.h,
                                          width: 180.w
                                      ),
                                      smallText(title: "Font")
                                    ],
                                  ),),
                                ],
                              ),
                            ),


                      // --------===------========  Done Button =======------===--------
                      SizedBox(height: 50.h,),
                      commonButton(
                          buttonName: "Done",
                          onTap: (){
                            controller.addNewText();
                          },
                          buttonColor: redColor,
                          buttonHeight: 140.h,
                          textStyle: TextStyle(color: whiteColor,fontWeight: FontWeight.w600),
                          buttonWidth: 1.sw
                      ),
                      SizedBox(height: 10.h,),

                    ]);
              }
            ); })
  );
}