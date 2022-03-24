import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/login_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/signup_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ----------- ======= image ======== ---------------
                SizedBox(
                  height: 80.h,
                ),
                Center(
                  child: imageWidget(
                      height: 900.h, width: 700.w, image: "assets/Asset 2.png"),
                ),
                // ----------- ======= title ======== ---------------
                SizedBox(
                  height: 70.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerTwo(
                        title: "Welcome to",
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 15.w,
                    ),
                    headerTwo(
                        title: "iFRESH",
                        color: redColor,
                        fontWeight: FontWeight.bold),
                  ],
                ),

                // ----------- ======= sub title ======== ---------------
                SizedBox(
                  height: 40.h,
                ),
                largeText(title: "Create an account or login to get started",color: blackColor),

                // ----------- ======= Login Button ======== ---------------
                SizedBox(
                  height: 110.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonButton(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        buttonColor: redColor,
                        buttonHeight: 140.h,
                        buttonWidth: 0.9.sw,
                        buttonName: "Login",
                        textStyle: TextStyle(color: whiteColor,)

                    ),
                  ],
                ),

                // ----------- ======= signup Button ======== ---------------
                SizedBox(
                  height: 60.h,
                ),
                InkWell(
                  onTap: (){
                    Get.to(() => SignUpScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(27.r),
                        border: Border.all(color: Color(0xff707070))
                    ),
                    height: 140.h,
                    width: 0.9.sw,
                    child: Align(
                        alignment: Alignment.center,
                        child: commonText(title: "Signup", textStyle: TextStyle(color: blackColor) )),
                  ),
                ),

                // ----------- ======= Continue without login ======== ---------------
                SizedBox(
                  height: 50.h,
                ),
                GetBuilder<UserAuthController>(
                  init: UserAuthController(),
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         InkWell(
                           onTap: () {
                             controller.signInAnonymously();
                           },
                           child: largeText(
                               title: 'Continue without login',
                               color: redColor,
                           ),
                         )
                    ],);
                  }
                ),
                SizedBox(
                  height: 20.h,
                ),


              ],
            ),
          ),
        ));
  }
}
