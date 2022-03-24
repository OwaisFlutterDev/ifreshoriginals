import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/constant/form_validator_constant.dart';
import 'package:ifreshoriginals_userapp/controller/form_validation_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/forgot_password_for_code_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordForEmailScreen extends StatelessWidget {
  const ForgotPasswordForEmailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final FormValidationController _formValidationController = Get.put(FormValidationController());
    final UserAuthController userAuthController = Get.put(UserAuthController());

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
                    image: "assets/Asset 9.png",
                    width: 500.w,
                    height: 500.h,
                  ),

                  // -------- ===== Title ===== --------
                  SizedBox(height: 60.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerTwo(
                          title: "Forgot password?",
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
                          // title: "Enter your email address to receive verification code.",
                          title: "Enter your email address to receive reset password link.",
                          textAlign: TextAlign.center,
                          color: blackColor,
                      ),
                    ],
                  ),

                  // -------- ===== Text Form Field ===== --------
                  SizedBox(height: 140.h,),
                  Form(
                            key: _formValidationController.forgetPasswordFormKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                commonTextFormField(
                                  hintText: "loremipsum@gmail.com",
                                  validator: FormValidatorConstant.emailValidator,
                                  prefixIcon: (CupertinoIcons.mail),
                                  controller:  _formValidationController.emailController,
                                ),


                              ],)),

                  //  -------- ======= Login Button ======== --------
                  SizedBox(height: 90.h,),
                  commonButton(
                      buttonName: "Send Request",
                      buttonColor: redColor,
                      onTap: () {

                        if (_formValidationController.forgetPasswordFormKey.currentState!.validate()) {
                          userAuthController.resetPasswordRequest();
                        } else {
                          Get.snackbar("SignIn Screen",
                              "Please Enter Email...",
                              duration: Duration(seconds: 3));
                        }

                        //------------------------------------
                        // Get.to(() => ForgotPasswordForCodeScreen());
                      },
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
