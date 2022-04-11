import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/form_validation_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/bottom_navigation_bar_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/forgot_password_for_email_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/signup_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/form_validator_constant.dart';
import '../../../controller/user_auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    FormValidationController _formValidationController = Get.put(FormValidationController());
    UserAuthController userAuthController = Get.put(UserAuthController());

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: SingleChildScrollView(
              child: GetBuilder<UserAuthController>(
                builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // -------- ===== image ===== --------
                      SizedBox(height: 20.h,),
                      imageWidget(
                        image: "assets/Asset 1.png",
                        width: 500.w,
                        height: 300.h,
                      ),

                      // -------- ===== Title ===== --------
                      SizedBox(height: 16.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headerTwo(
                            title: "Hello,",
                            color: blackColor,
                            fontWeight:  FontWeight.bold
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headerTwo(
                              title: "Login for Continue",
                              color: blackColor,
                              fontWeight: FontWeight.bold
                          ),
                        ],
                      ),

                      // -------- ===== Text Form Field ===== --------
                      SizedBox(height: 65.h,),
                      GetBuilder<FormValidationController>(
                        init: FormValidationController(),
                        builder: (controller) {
                          return Form(
                              key: _formValidationController.logInFormKey,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                 commonTextFormField(
                                     hintText: "loremipsum@gmail.com",
                                     validator: FormValidatorConstant.emailValidator,
                                     prefixIcon: (CupertinoIcons.mail),
                                     controller:  controller.emailController,
                                 ),
                                  SizedBox(height: 40.h,),
                                  commonTextFormField(
                                      hintText: "Password",
                                      validator: FormValidatorConstant.commonValidator,
                                      controller:  controller.passwordController,
                                      prefixIcon: (Icons.lock_outline_rounded),
                                      obscureText: controller.isHidden,
                                      suffixIcon: InkWell(
                                          onTap: (){
                                            controller.togglePassword();
                                          },
                                          child: controller.isHidden == true ?
                                          Icon(CupertinoIcons.eye_slash,color: Color(0xffABB3BB),size: 60.r,) :
                                          Icon(CupertinoIcons.eye,color: Colors.blue,size: 60.r,)
                                      )
                                  )
                                ],));
                        }
                      ),

                      //  -------- ======= Remember me & Forgot Password ======== --------
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [
                            GetBuilder<FormValidationController>(
                              builder: (controller) {
                                return Checkbox(
                                    value: controller.isChecked,
                                    onChanged: (check)  {
                                      controller.isChecked = check!;
                                      controller.update();
                                    }
                                );
                              }
                            ),
                            smallText(title: "Remember me", color: Color(0xff393F45))
                          ],
                        ),
                          InkWell(
                              onTap: () => Get.to(() => ForgotPasswordForEmailScreen()),
                              child: smallText(title: "Forgot password?", color: Color(0xff2AA3D8)))
                      ],),

                      //  -------- ======= Login Button ======== --------
                      SizedBox(height: 50.h,),
                      controller.signInBool == false ? commonButton(
                          buttonName: "Login",
                          buttonColor: redColor,
                          onTap: () {
                            if (_formValidationController.logInFormKey.currentState!.validate()) {
                              userAuthController.signInThroughEmailAndPass();
                            } else {
                              Get.snackbar("SignIn Screen",
                                  "Please Fill All The Fields",
                                  duration: Duration(seconds: 3));
                            }

                          } ,

                          buttonWidth: 1.sw,
                        textColor: whiteColor,
                      ) : CircularProgressIndicator(),

                      //  -------- ======= or , google, fb sign in buttons & signup  ======== --------
                      SizedBox(height: 50.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          commonText(title: "or",textStyle: TextStyle(color: blackColor))
                      ],),
                      SizedBox(height: 45.h,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ------ ====== google button ======= -------
                              controller.googleSignInBool == false ? InkWell(
                                onTap: () {
                                  userAuthController.signInWithGoogle();
                                },
                                child: Container(
                                 height: 170.h,
                                 width: 170.w,
                                 decoration: BoxDecoration(
                                   color: whiteColor,
                                   borderRadius: BorderRadius.circular(30.r)
                                 ),
                                 child: Center(
                                   child: Image(image: AssetImage("assets/Asset 6.png"),
                                                fit: BoxFit.scaleDown,width: 90.w,height: 90.h,
                                     ),
                                 ),
                             ),
                              ) : CircularProgressIndicator(),
                              // SizedBox(width: 200.w,),
                              // ------ ====== fb button ======= -------
                              // InkWell(
                              //   onTap: () {},
                              //   child: Container(
                              //     height: 170.h,
                              //     width: 170.w,
                              //     decoration: BoxDecoration(
                              //         color: whiteColor,
                              //         borderRadius: BorderRadius.circular(30.r)
                              //     ),
                              //     child: Center(
                              //       child: Image(image: AssetImage("assets/Asset 7.png"),
                              //         fit: BoxFit.scaleDown,width: 90.w,height: 90.h,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],),
                          SizedBox(height: 190.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              smallText(
                                title: "Don’t Have an Account?",
                                color:  blackColor,
                              ),
                              SizedBox(width: 20.w,),
                              // ------ ====== google button ======= -------
                              InkWell(
                                onTap: (){
                                  // _formValidationController.clearTextField();
                                  Get.off(() => SignUpScreen());
                                },
                                child: smallText(
                                  title: "Sign Up",
                                  color:  redColor,
                                ),
                              ),
                            ],),
                        ],
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  );
                }
              ),
            ),
          ),
        ));
  }
}
