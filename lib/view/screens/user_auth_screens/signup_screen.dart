import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/constant/form_validator_constant.dart';
import 'package:ifreshoriginals_userapp/controller/form_validation_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/login_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final UserAuthController userAuthController = Get.put(UserAuthController());
  final FormValidationController formValidationController = Get.put(FormValidationController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: SingleChildScrollView(
              child: Column(
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
                          title: "Welcome,",
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
                          title: "Signup to get Started",
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
                          key: controller.signUpFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              commonTextFormField(
                                hintText: "Username",
                                validator: FormValidatorConstant.commonValidator,
                                controller:  controller.usernameController,
                                prefixIcon: (CupertinoIcons.person),
                              ),
                              SizedBox(height: 40.h,),
                              commonTextFormField(
                                hintText: "loremipsum@gmail.com",
                                validator: FormValidatorConstant.emailValidator,
                                controller:  controller.emailController,
                                prefixIcon: (CupertinoIcons.mail),
                              ),
                              SizedBox(height: 40.h,),
                              commonTextFormField(
                                  hintText: "Password",
                                  validator: FormValidatorConstant.commonValidator,
                                  controller: controller.passwordController,
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
                              ),
                              SizedBox(height: 40.h,),
                              commonTextFormField(
                                  hintText: "Confirm Password",
                                  validator:  (value){
                                        if(value.isEmpty)
                                        {
                                        return 'Please re-enter password';
                                        }
                                        if( value !=
                                        formValidationController.passwordController.text
                                            ){
                                        return "Password does not match";
                                        }
                                        return null;
                                        },
                                  controller:  controller.conformPasswordController,
                                  prefixIcon: (Icons.lock_outline_rounded),
                                  obscureText: controller.isHiddenForConformPass,
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        controller.toggleConformPassword();
                                      },
                                      child: controller.isHiddenForConformPass == true ?
                                      Icon(CupertinoIcons.eye_slash,color: Color(0xffABB3BB),size: 60.r,) :
                                      Icon(CupertinoIcons.eye,color: Colors.blue,size: 60.r,)
                                  )
                              )
                            ],));
                    }
                  ),

                  //  -------- ======= Login Button ======== --------
                  SizedBox(height: 60.h,),
                  GetBuilder<UserAuthController>(
                    init: UserAuthController(),
                    builder: (controller) {
                      return controller.createAccountBool == false ? commonButton(
                          buttonName: "Signup",
                          buttonColor: redColor,
                          onTap: () {
                            // formValidationController.signUpFormKey.currentState!.save();
                            if (formValidationController.signUpFormKey.currentState!.validate()) {
                                userAuthController.createAccount();
                            } else {
                              Get.snackbar("SignUp Screen",
                                  "Please Fill All The Fields",
                                  duration: Duration(seconds: 3));
                            }
                          },

                        buttonWidth: 1.sw,
                        textColor: whiteColor,
                      ) : CircularProgressIndicator();
                    }
                  ),

                  //  -------- ======= Already Have an Account? signin  ======== --------
                  SizedBox(height: 240.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallText(
                        title: "Already Have an Account?",
                        color:  blackColor,
                      ),
                      SizedBox(width: 20.w,),
                      // ------ ====== google button ======= -------
                      InkWell(
                        onTap: (){
                          // _formValidationController.clearTextField();
                          Get.off(() => LoginScreen());
                        },
                        child: smallText(
                          title: "Sign In",
                          color:  redColor,
                        ),
                      ),
                    ],),
                  SizedBox(height: 10.h,)
                ],
              ),
            ),
          ),
        ));
  }
}
