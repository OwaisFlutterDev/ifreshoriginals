import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/saved_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/edit_profile_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/order_history_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/home_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: GetBuilder<UserAuthController>(
              init: UserAuthController(),
              builder: (controller) {
                return FirebaseAuth.instance.currentUser!.isAnonymous ?
                //-------------------------------------------------------------
                //     ------ ========== If SignIn Anonymously   ======== ------
                //-------------------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: GetBuilder<UserProfileController>(
                          init: UserProfileController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Center(
                                  child: Container(
                                    height: 330.h,
                                    width: 330.w,
                                    decoration: BoxDecoration(
                                        color: redColor,
                                        shape: BoxShape.circle,
                                          ),
                                    child: Center(
                                      child: commonText(
                                          title: "G",
                                          textAlign:  TextAlign.center,
                                          textStyle:  TextStyle(
                                            color: whiteColor,
                                            fontSize: 120.sp
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40.h,),
                                // --- === name === ---
                                Center(
                                    child: largeText(title: "Guest Account",fontWeight: FontWeight.bold)),
                                SizedBox(height: 15.h,),
                                // // --- === email === ---
                                // Center(child: smallText(title: "To ",)),

                              ],
                            );
                          }
                      ),
                    ),
                  ],
                ) :

                //-------------------------------------------------
                //     ------ ========== Profile image and Data ======== ------
                //-------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 35.h,),

                        //-------------------------------------------------
                        //     ------ ========== Profile image and Data ======== ------
                        //-------------------------------------------------
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: GetBuilder<UserProfileController>(
                              init: UserProfileController(),
                              builder: (controller) {
                                return Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 330.h,
                                      width: 330.w,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: NetworkImage(controller.userProfileModel.image!),fit: BoxFit.cover)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40.h,),
                                  // --- === name === ---
                                  Center(
                                      child: largeText(title: controller.userProfileModel.username,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 15.h,),
                                  // --- === email === ---
                                  Center(child: smallText(title: controller.userProfileModel.email,)),
                                  SizedBox(height: 60.h,),
                                  // --- === Edit Profile Button === ---
                                  commonButton(
                                      buttonName: "Edit Profile",
                                      buttonColor: redColor,
                                      buttonWidth: 420.w,
                                      buttonHeight: 107.h,
                                      textStyle: TextStyle(fontSize: 40.sp,color: whiteColor,),
                                      onTap: () => Get.to(() => EditProfileScreen())
                                  )
                                ],
                              );
                            }
                          ),
                        ),
                        SizedBox(height: 90.h,),
                        Divider(height: 0.2.h,color: Colors.black12,),
                        //-------------------------------------------------
                        //     ------ ========== Bottom Section ======== ------
                        //-------------------------------------------------
                        SizedBox(height: 90.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(
                            children: [
                              //-------------------------------------------------
                              //     ------ ========== Order History section ======== ------
                              //-------------------------------------------------
                              // -- == section title == ---
                              sectionTitleWidget(
                                  title: "Order History",
                                  onTap: () => Get.to(() => OrderHistoryScreen())
                              ),
                              SizedBox(height: 50.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  savedAndDesignHistoryWidget(
                                    image: "https://tinyurl.com/y9ax33uv",
                                    name: "Football Love",
                                  ),
                                  savedAndDesignHistoryWidget(
                                    image: "https://tinyurl.com/ybp5syc4",
                                    name: "Sports",
                                  ),
                                  savedAndDesignHistoryWidget(
                                    image: "https://tinyurl.com/y8hy8lal",
                                    name: "Animal Kingdom",
                                  ),
                                ],
                              ),

                              //-------------------------------------------------
                              //     ------ ========== Saved Designs section ======== ------
                              //-------------------------------------------------
                              SizedBox(height: 90.h,),
                              // -- == section title == ---
                              sectionTitleWidget(
                                  title: "Saved Designs",
                                  onTap: () => Get.to(() => SavedDesignsScreen())
                              ),
                              SizedBox(height: 50.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  savedAndDesignHistoryWidget(
                                    image: "https://tinyurl.com/y9ax33uv",
                                    name: "Football Love",
                                  ),
                                  savedAndDesignHistoryWidget(
                                    image: "https://tinyurl.com/ybp5syc4",
                                    name: "Sports",
                                  ),
                                  savedAndDesignHistoryWidget(
                                    image: "https://tinyurl.com/y8hy8lal",
                                    name: "Animal Kingdom",
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h,),
                          ],),
                        )

                    ]);
              }
            )),
      ),
    );
  }
}
