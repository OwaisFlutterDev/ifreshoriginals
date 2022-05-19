import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/welcome_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';

//-------------------------------------------------
//     ------ ========== Cart Item Widget ======== ------
//-------------------------------------------------

Widget cartItemWidget({String? image, void Function()? editItem,void Function()? deleteItem,
                     String? category, String? size, String? quantity, String? price
}) {
  return Container(
    height: 460.h,
    width: 1.sw,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40.r),
      boxShadow: const <BoxShadow>[
        BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(1, 2)
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ------ ===== Shirt image + details section ==== ------
        Row(
          children: [
            SizedBox(width: 20.w,),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 30.h),
              child: Container(
                height: 300.h,
                width: 270.w,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    // boxShadow: const <BoxShadow>[
                    //   BoxShadow(
                    //       color: Colors.black12,
                    //       blurRadius: 5.0,
                    //       offset: Offset(1, 2)
                    //   )
                    // ],
                    // image: DecorationImage(image: NetworkImage(image!),fit: BoxFit.fill,)
                ),
                child: Container(
                  height: 280.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      // shape: BoxShape.circle,
                      // boxShadow: const <BoxShadow>[
                      //   BoxShadow(
                      //       color: Colors.black12,
                      //       blurRadius: 5.0,
                      //       offset: Offset(1, 2)
                      //   )
                      // ],
                      image: DecorationImage(image: NetworkImage(image!),fit: BoxFit.fill,)
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                    children: [
                      smallText(
                          title: category,
                          color: blackColor,
                          fontWeight: FontWeight.w600
                      )]
                ),
                SizedBox(height: 8.h,),
                Wrap(
                    children: [
                      commonText(
                        title: "Size:",
                        textStyle: TextStyle(
                          color: blackColor,
                          fontSize: 38.sp,
                        ),
                      ),
                      SizedBox(width: 24.w,),
                      commonText(
                        title: size,
                        textStyle: TextStyle(
                            color: blackColor,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 8.h,),
                Wrap(
                    children: [
                      commonText(
                        title: "Quantity:",
                        textStyle: TextStyle(
                          color: blackColor,
                          fontSize: 38.sp,
                        ),
                      ),
                      SizedBox(width: 24.w,),
                      commonText(
                        title: quantity,
                        textStyle: TextStyle(
                            color: blackColor,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 8.h,),
                Wrap(
                    children: [
                      commonText(
                        title: "Price:  \$",
                        textStyle: TextStyle(
                            color: blackColor,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      // SizedBox(width: 24.w,),
                      commonText(
                        title: price,
                        textStyle: TextStyle(
                            color: blackColor,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ]
                ),

              ],
            )
          ],),
        // ------ ===== button Section section ==== ------
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: editItem,
                child: Image(image: AssetImage("assets/Asset 68.png"),width: 160.w,height: 160.h,fit: BoxFit.scaleDown,)),
            SizedBox(width: 2.w,),
            InkWell(
                onTap: deleteItem,
                child: Image(image: AssetImage("assets/Asset 69.png"),width: 160.w,height: 160.h,fit: BoxFit.scaleDown,)),

            SizedBox(width: 10.w,),
          ],)


      ],
    ),
  );
}

//-------------------------------------------------
//     ------ ========== Alert Dialog Widget ======== ------
//-------------------------------------------------
Widget alertDialogWidget() {
  return AlertDialog(
      scrollable: true,
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(15))),
      backgroundColor: whiteColor,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
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
            Center(
              child: Container(
                  height: 230.h,
                  width: 230.w,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        offset: Offset(0, 5,),
                      )
                    ],
                  ),
                  child: Center(child: Text( "!",style:  TextStyle(
                      color: Colors.white,fontSize: 100.sp, fontWeight: FontWeight.bold)))
              ),
            ),
            SizedBox(height: 70.h,),
            Center(child: headerTwo(title: "Please Sign In", fontWeight: FontWeight.w700,color: blackColor)),
            SizedBox(height: 50.h,),
            Center(child: Wrap(
              children: [
                smallText(title: "In order to Proceed please Sign In to your account",textAlign: TextAlign.center),
              ],
            )),
            SizedBox(height: 90.h,),
            // --------===------========  sign in function =======------===--------
            InkWell(
              onTap: (){
                Get.offAll(() => WelcomeScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(70.r)
                ),
                height: 123.h,
                width: 0.5.sw,
                child: Align(
                    alignment: Alignment.center,
                    child: commonText(title: "Sign In", textStyle: TextStyle(
                        color: whiteColor,fontWeight: FontWeight.w500,fontSize: 50.sp) )),
              ),
            ),
            SizedBox(height: 30.h,),

          ]));
}

// AlertDialog shirtColorAlertDialogWidgetSecondImageOfOd() {
//   return ;
// }