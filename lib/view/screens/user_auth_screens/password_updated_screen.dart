import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: bgColor,
        // ----- ===  appbar === -----
        appBar: appbarForUserAuth(
            title: "Forgot Password"
        ),
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // -------- ===== image ===== --------
                  SizedBox(height: 80.h,),
                  imageWidget(
                    image: "assets/Asset 11.png",
                    width: 450.w,
                    height: 450.h,
                  ),

                  // -------- ===== Title ===== --------
                  SizedBox(height: 90.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerTwo(
                          title: "Password Updated",
                          color: blackColor,
                          fontWeight:  FontWeight.bold
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h,),
                  //  ---------- ===  sub title === ---------
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      smallText(
                          title: "Your password has been updated!",
                          color: blackColor,
                          textAlign: TextAlign.center
                      ),
                    ],
                  ),

                  //  -------- ======= Login Button ======== --------
                  SizedBox(height: 150.h,),
                  commonButton(
                      buttonName: "Login",
                      buttonColor: redColor,
                      onTap: () {},
                      buttonHeight: 150.h,
                      buttonWidth: 1.sw,
                      textStyle: TextStyle(color: whiteColor,)
                  ),
                  SizedBox(height: 10.h,)
                ],
              ),
            ),
          ),
        ));
  }


}
