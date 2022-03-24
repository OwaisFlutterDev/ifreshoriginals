import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/constant/form_validator_constant.dart';
import 'package:ifreshoriginals_userapp/controller/form_validation_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/password_updated_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);
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

                  // -------- ===== Title ===== --------
                  SizedBox(height: 70.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerTwo(
                          title: "New password",
                          color: blackColor,
                          fontWeight:  FontWeight.bold
                      ),
                    ],
                  ),
                  SizedBox(height: 45.h,),
                  //  ---------- ===  sub title === ---------
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      smallText(
                        title: "Please enter your new password and sign in to your account.",
                        color: blackColor,
                        textAlign: TextAlign.center
                      ),
                    ],
                  ),

                  // -------- ===== Text Form Field ===== --------
                  SizedBox(height: 140.h,),
                  GetBuilder<FormValidationController>(
                    init: FormValidationController(),
                    builder: (controller) {
                      return Form(
                        key: controller.newPasswordFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              commonTextFormField(
                                  hintText: "New Password",
                                  validator: FormValidatorConstant.commonValidator,
                                  controller: controller.newPasswordController,
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
                              SizedBox(height: 80.h,),
                              commonTextFormField(
                                  hintText: "Confirm New Password",
                                  validator: FormValidatorConstant.commonValidator,
                                  controller:  controller.newConformPasswordController,
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
                  SizedBox(height: 130.h,),
                  commonButton(
                      buttonName: "Confirm",
                      buttonColor: redColor,
                      onTap: () {
                        Get.to(() => PasswordUpdatedScreen());
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
