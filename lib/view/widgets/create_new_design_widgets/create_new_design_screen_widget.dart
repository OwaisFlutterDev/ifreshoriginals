import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_image_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:get/get.dart';
import '../../../constant/form_validator_constant.dart';
import '../../../controller/create_new_design_controller.dart';

final CreateNewDesignController createNewDesignController = Get.put(CreateNewDesignController());
final FunctionalityOnImageController functionalityOnImageController = Get.put(FunctionalityOnImageController());

Widget imageButton({void Function()? onTap, String? image, String? title}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 220.w,
          height: 230.h,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(40.r),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                offset: Offset(0, 2,),
              )
            ],
          ),
          child: Center(
              child: imageWidget(
                  height: 180.h,
                  width: 140.w,
                  image: image
              )
          ),
        ),
        SizedBox(height: 30.h,),
        smallText(title: title,textAlign: TextAlign.center)
      ],),
  );
}

Widget zoomAndChangeImageSideWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(children: [
        // --- ===  + button === ---
        InkWell(
          onTap: (){
            functionalityOnImageController.zoomIn();
          },
          child: imageWidget(
            image: "assets/Asset 39.png",
            width: 170.w,
            height: 170.h,
          ),
        ),
        // --- ===  _ button === ---
        SizedBox(width: 7.w,),
        InkWell(
          onTap: (){
            functionalityOnImageController.zoomOut();
          },
          child: imageWidget(
            image: "assets/Asset 40.png",
            width: 170.w,
            height: 170.h,
          ),
        ),
        SizedBox(width: 18.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 230.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(70.r),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    offset: Offset(0, 2,),
                  )
                ],
              ),
              child: Center(
                child: smallText(
                  color: redColor,
                  title: "\$14.99" ,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10.h,)
          ],
        ),
      ],
      ),
      InkWell(
        onTap: (){
          functionalityOnImageController.flipCarController.flipcard();
        },
        child: imageWidget(
          image: "assets/Asset 41.png",
          width: 170.w,
          height: 170.h,
        ),
      ),

    ],);
}

Widget saveImageWidget(context) {
  return GetBuilder<CreateNewDesignController>(
    init: CreateNewDesignController(),
    builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 30.w,),
          SizedBox(width: 50.w,),
          headerThree(title: "Animal Kingdom",color: blackColor, fontWeight: FontWeight.w700),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        scrollable: true,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                        backgroundColor: bgColor,
                        content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:  [
                                  InkWell(
                                      onTap: (){
                                        Get.back();
                                        },
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

                              SizedBox(height: 70.h,),

                              GetBuilder<CreateNewDesignController>(
                                  builder: (controller) {
                                    return controller.saveNewDesignShirtBool == true ? Wrap(
                                      children: [
                                        commonText(
                                          title: "Please Wait The Shirt Design Is Saving...",
                                          textAlign: TextAlign.center,
                                          textStyle: TextStyle(color: blackColor,fontSize: 18)
                                        ),
                                      ],
                                    ) : Form(
                                    key: controller.shirtDesignGlobalKey,
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          commonText(
                                              title: "   Give Design Name",
                                              textStyle: TextStyle(fontSize: 32.sp)
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30.h,),
                                      commonTextFormField(
                                        hintText: "Design Name",
                                        controller: controller.designNameController,
                                        validator: FormValidatorConstant.commonValidator,
                                        prefixIcon: (CupertinoIcons.arrow_right_circle)
                                      )
                                    ],),
                                  );
                                }
                              ),
                              SizedBox(height: 200.h,),
                              // --------===------========  save image button =======------===--------

                              GetBuilder<CreateNewDesignController>(
                                builder: (controller) {
                                  return controller.saveNewDesignShirtBool == true ? CircularProgressIndicator() :
                                  InkWell(
                                    onTap: (){
                                      if (controller.shirtDesignGlobalKey.currentState!.validate()) {
                                        controller.saveNewShirtDesign();
                                      } else {
                                        Get.snackbar("New Shirt Design Screen",
                                            "Please Fill The Field",
                                            duration: Duration(seconds: 3));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: redColor,
                                          borderRadius: BorderRadius.circular(70.r)
                                      ),
                                      height: 39,
                                      width: 0.6.sw,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: commonText(title: "Save Shirt Design", textStyle: TextStyle(
                                              color: whiteColor,fontWeight: FontWeight.w500,fontSize: 12) )),
                                    ),
                                  );
                                }
                              ) ,

                              SizedBox(height: 30.h,),

                            ]));
                  });
            },
            child: Row(
              children: [
                Container(
                  width: 170.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                      color: Colors.transparent
                  ),
                  child: Image(image: AssetImage("assets/Asset 34.png"),
                    fit: BoxFit.scaleDown,),
                ),
                SizedBox(width: 20.w,)
              ],
            ),
          ),
        ],
      );
    }
  );
}

Widget fontButton({ Function()? onTap, Color? buttonColor, double? buttonWidth ,
  double? buttonHeight , String? buttonName, TextStyle? style}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(27.r,),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 5,),
          )
        ],

      ),
      height: buttonHeight,
      width: buttonWidth,
      child: Align(
          alignment: Alignment.center,
          child: Text(buttonName ?? "" , style: style)),
    ),
  );
}