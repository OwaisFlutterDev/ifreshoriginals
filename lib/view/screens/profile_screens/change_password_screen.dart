import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/constant/form_validator_constant.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  UserProfileController userProfileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: "Change Password",
          leadingWidget: InkWell(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back,color: blackColor,size: 70.r),
          )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 50.w),
              child: GetBuilder<UserProfileController>(
                init: UserProfileController(),
                builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          largeText(title: "Password",color: blackColor,fontWeight: FontWeight.w600),
                        ],
                      ),
                      SizedBox(height: 50.h,),
                      Form(
                         key: userProfileController.changeProfileFormKey,
                          child: Column(children: [
                            commonTextFormField(
                              prefixIcon: (Icons.lock_outline_rounded),
                              hintText: "Current Password",
                              validator:  FormValidatorConstant.commonValidator,
                              controller: userProfileController.currentPasswordProfileController
                            ),
                            SizedBox(height: 50.h,),
                            commonTextFormField(
                                prefixIcon: (Icons.lock_outline_rounded),
                                hintText: "New Password",
                                validator:  FormValidatorConstant.commonValidator,
                                controller: userProfileController.newPasswordProfileController
                            ),
                            SizedBox(height: 50.h,),
                            commonTextFormField(
                                prefixIcon: (Icons.lock_outline_rounded),
                                hintText: "Conform New Password",
                                controller: userProfileController.conformPasswordProfileController,
                               validator:  (value){
                                if(value.isEmpty)
                                {
                                  return 'Please re-enter password';
                                }
                                if( value != userProfileController.newPasswordProfileController.text
                                ){
                                  return "Password does not match";
                                }
                                return null;
                              },
                            ),
                      ],)),
                      SizedBox(height: .3.sh,),

                      commonButton(
                        buttonWidth: 1.sw,
                        buttonName: "Change Password",
                        buttonColor: redColor,
                        textColor: whiteColor,
                        onTap: () {
                          if (userProfileController.changeProfileFormKey.currentState!.validate()) {
                            controller.changePassword();
                          } else {
                            Get.snackbar("Change Profile Notification",
                                "Please Fill All The Fields",
                                duration: Duration(seconds: 3));
                          }

                        }
                      ),
                    ],
                  );
                }
              ),
            )),
      ),
    );
  }
}
