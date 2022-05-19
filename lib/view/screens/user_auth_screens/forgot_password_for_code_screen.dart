// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/form_validation_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/new_password_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPasswordForCodeScreen extends StatelessWidget {
  const ForgotPasswordForCodeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? smsCode;
    final FormValidationController _formValidationController = Get.put(FormValidationController());

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
                  SizedBox(height: 30.h,),
                  imageWidget(
                    image: "assets/Group 309.png",
                    width: 500.w,
                    height: 500.h,
                  ),

                  // -------- ===== Title ===== --------
                  SizedBox(height: 60.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerTwo(
                          title: "Verify your email",
                          color: blackColor,
                          fontWeight:  FontWeight.bold
                      ),
                    ],
                  ),
                  SizedBox(height: 35.h,),
                  //  ---------- ===  sub title === ---------
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      smallText(
                        title: "Enter the 4 digit code that you received on your email",
                        color: blackColor,
                      ),
                    ],
                  ),

                  // -------- ===== Text Form Field ===== --------
                  SizedBox(height: 140.h,),
                  OTPTextField(

                    length: 4,
                    width: 1.sw,
                    fieldWidth: 160.r,
                    style: TextStyle(
                        fontSize: 60.sp
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,

                      onChanged: (value) {
                        print("Changed: " + value);
                        // _formValidationController.smsCode = value;
                      },

                      onCompleted: (pin) {
                        // print("Completed: " + pin);
                        _formValidationController.smsCode = pin;
                        // _formValidationController.update();
                      }
                  ),

                  //  -------- ======= Login Button ======== --------
                  SizedBox(height: 140.h,),
                  commonButton(
                      buttonName: "Verify",
                      buttonColor: redColor,
                      onTap: () {
                        Get.to(() => NewPasswordScreen());
                        print("Sms Code ${_formValidationController.smsCode}");
                      },

                      buttonWidth: 1.sw,
                    textColor: whiteColor,
                  ),
                  SizedBox(height: 10.h,)
                ],
              ),
            ),
          ),
        ));
  }


}
