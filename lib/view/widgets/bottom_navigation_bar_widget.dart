import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/drawer_screens/FAQ%E2%80%99s_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/drawer_screens/privacy_policy.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/drawer_screens/terms_and_conditions.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/saved_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


Widget drawerWidget() {
  UserAuthController userAuthController = Get.put(UserAuthController());
  return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return  Column(
        children: [
          SizedBox(height: 90.h,),
              FirebaseAuth.instance.currentUser!.isAnonymous ?
                //-------------------------------------------------------------
                //     ------ ========== If SignIn Anonymously   ======== ------
                //-------------------------------------------------------------
                Column(
                  children: [
                    Container(
                      height: 240.h,
                      width: 240.w,
                      decoration: BoxDecoration(
                          color: redColor,
                          shape: BoxShape.circle,
                      ),
                     child:  Center(
                        child: commonText(
                            title: "G",
                            textAlign:  TextAlign.center,
                            textStyle:  TextStyle(
                                color: whiteColor,
                                fontSize: 75.sp
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h,),
                    largeText(title: "Guest Account",fontWeight: FontWeight.bold),
                    SizedBox(height: 10.h,),
                    // smallText(title: controller.userProfileModel.email,),
                    // SizedBox(height: 10.h,),
                  ],
                ) :
                //-------------------------------------------------------------
                //     ------ ========== Profile image and Data   ======== ------
                //-------------------------------------------------------------
                Column(
                 children: [
                  Container(
                    height: 240.h,
                    width: 240.w,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: CachedNetworkImageProvider(controller.userProfileModel.image!),fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(height: 17.h,),
                  largeText(title: controller.userProfileModel.username,fontWeight: FontWeight.bold),
                  SizedBox(height: 10.h,),
                  smallText(title: controller.userProfileModel.email,),
                  SizedBox(height: 10.h,),
                ],
              ),

          Divider(),
          SizedBox(height: 20.h,),

          // ---=--=-------======== Saved Designs  ========-------=--=---
          rowDrawerWidget(
            title: "Saved Designs",
            image: "assets/Asset 78.png",
            onTap: () => Get.to(() => SavedDesignsScreen()),
          ),
          SizedBox(height: 60.h,),
          rowDrawerWidget(
            title: "Terms & Conditions",
            image: "assets/Asset 79.png",
            onTap: () => Get.to(() => TermsAndConditionScreen()),
          ),
          SizedBox(height: 60.h,),
          rowDrawerWidget(
            title: "Privacy Policy",
            image: "assets/Asset 80.png",
            onTap: () => Get.to(() => PrivacyPolicyScreen()),
          ),
          SizedBox(height: 60.h,),
          rowDrawerWidget(
            title: "FAQ's",
            image: "assets/Asset 81.png",
            onTap: () => Get.to(() => FAQsScreen()),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                rowDrawerWidget(
                  title: "Logout",
                  image: "assets/Asset 82.png",
                  onTap: () {
                    userAuthController.logOut();
                  },
                ),
                SizedBox(height: 60.h,)
              ],
            ),
          )
        ],
      );
    }
  );
}

Widget rowDrawerWidget({String? image, String? title, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(children: [
        SizedBox(width: 50.w,),
         Container(
             color: Colors.transparent,
             height: 80.h,
             width: 80.w,
             child: Image(image: AssetImage(image!),fit: BoxFit.scaleDown,)),
             SizedBox(width: 50.w,),
             largeText(title: title),

      ],),
  );
}
