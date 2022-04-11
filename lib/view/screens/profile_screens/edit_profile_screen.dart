import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/change_password_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: "Edit Profile",
          leadingWidget: InkWell(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back, color: blackColor, size: 70.r),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: GetBuilder<UserProfileController>(
              init: UserProfileController(),
              builder: (controller) {
                return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      largeText(
                          title: "Basic Information",
                          color: blackColor,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                   Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  controller.imageFile != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.blue.shade800,
                                          backgroundImage: FileImage(
                                            controller.imageFile!,
                                          ),
                                        )
                                      :
                                  // controller.userProfileModel.image != null ?
                                           CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.blue.shade800,
                                              backgroundImage: NetworkImage(controller.userProfileModel.image!),
                                            ),
                                          // : Container(),
                                  Positioned(
                                      right: 1,
                                      bottom: 0,
                                      child: InkWell(
                                        onTap: () {
                                          controller.getImage();
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Icon(
                                            CupertinoIcons.camera,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ]),
                  SizedBox(height: 60.h,),
                  Form(
                    key: controller.editProfileFormKey,
                      child: Column(
                        children: [
                          commonTextFormField(
                            prefixIcon: (CupertinoIcons.person),
                            hintText: "Username",
                            controller: controller.usernameProfileController
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          commonTextFormField(
                            prefixIcon: (CupertinoIcons.phone),
                            hintText: "Phone Number",
                            controller: controller.phoneNumberProfileController,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          commonTextFormField(
                            prefixIcon: (CupertinoIcons.location),
                            hintText: "Address",
                            controller: controller.addressProfileController
                          ),
                    ],
                  )),
                  SizedBox(
                    height: .2.sh,
                  ),
                  controller.updateDataBool == false ? commonButton(
                    buttonWidth: 1.sw,
                    buttonName: "Save",
                    buttonColor: redColor,
                    textColor: whiteColor,
                    onTap: () {
                      controller.updateDataOfProfile();
                    }
                  ) : CircularProgressIndicator(),
                  SizedBox(
                    height: 70.h,
                  ),
                  commonButton(
                      buttonWidth: 1.sw,
                      buttonName: "Change Password",
                      buttonColor: whiteColor,
                      textColor: blackColor,
                      onTap: () => Get.to(() => ChangePasswordScreen())),
                   SizedBox(height: 20.h,)
                ],
              );
            }
          ),
        )),
      ),
    );
  }
}
