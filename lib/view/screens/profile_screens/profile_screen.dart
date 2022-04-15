import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_auth_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/saved_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/profile_screens/edit_profile_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/home_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);
   final HomeController homeController = Get.find<HomeController>();
   OpenedDesignController openedDesignController = Get.put(OpenedDesignController());

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
                                      buttonHeight: 37,
                                      buttonName: "Edit Profile",
                                      buttonColor: redColor,
                                      buttonWidth: 420.w,
                                      textColor: whiteColor,
                                       textSize: 12.5,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //-------------------------------------------------
                              //     ------ ========== Order History section ======== ------
                              //-------------------------------------------------
                              // -- == section title == ---
                              // sectionTitleWidget(
                              //     title: "Order History",
                              //     onTap: () => Get.to(() => OrderHistoryScreen())
                              // ),
                              // SizedBox(height: 50.h,),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     savedAndDesignHistoryWidget(
                              //       image: "https://tinyurl.com/y9ax33uv",
                              //       name: "Football Love",
                              //     ),
                              //     savedAndDesignHistoryWidget(
                              //       image: "https://tinyurl.com/ybp5syc4",
                              //       name: "Sports",
                              //     ),
                              //     savedAndDesignHistoryWidget(
                              //       image: "https://tinyurl.com/y8hy8lal",
                              //       name: "Animal Kingdom",
                              //     ),
                              //   ],
                              // ),

                              //-------------------------------------------------
                              //     ------ ========== Saved Designs section ======== ------
                              //-------------------------------------------------
                              // SizedBox(height: 90.h,),
                              // -- == section title == ---
                           Obx(
                                () => homeController.savedDesignDataList.isNotEmpty ? sectionTitleWidget(
                                  title: "Saved Designs",
                                  onTap: () => Get.to(() => SavedDesignsScreen())
                              ): Container()),
                              SizedBox(height: 50.h,),
                              Obx(
                                    () => homeController.savedDesignDataList.isNotEmpty ?  Container(
                                    color: Colors.transparent,
                                     height: 370.h,
                                     child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.savedDesignDataList.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            savedAndDesignHistoryWidget(
                                                image: homeController.savedDesignDataList[index].frontImageOfDesign,
                                                name: homeController.savedDesignDataList[index].designName,
                                                onTap: () async {

                                                  homeController.selectedFrontImageOfOpenedDesign =  homeController.savedDesignDataList[index].frontImage;
                                                  homeController.selectedBackImageOfOpenedDesign =   homeController.savedDesignDataList[index].backImage;
                                                  homeController.selectedShirtNameOfOpenedDesign =   homeController.savedDesignDataList[index].designName;
                                                  homeController.selectedShirtTypeOfOpenedDesign =   homeController.savedDesignDataList[index].shirtType;
                                                  homeController.update();


                                                  openedDesignController.selectedColorsForShirt = homeController.savedDesignDataList[index].firstShirtColor;
                                                  openedDesignController.hexToColor();
                                                  openedDesignController.selectedColorsForShirtSecondImage = homeController.savedDesignDataList[index].secondShirtColor;
                                                  openedDesignController.hexToColorForSecondShort();

                                                  // --------= -=-=-= clear lists =-=-=- =--------
                                                  openedDesignController.stickerListFirstImageOfOD.clear();
                                                  openedDesignController.stickerListSecondImageOfOD.clear();
                                                  openedDesignController.imageListOfOd.clear();
                                                  openedDesignController.imageListSecondImageOfOd.clear();
                                                  openedDesignController.textListOfOd.clear();
                                                  openedDesignController.textListForSecondImageOfOd.clear();

                                                  openedDesignController.docID = homeController.savedDesignDataList[index].id;
                                                  openedDesignController.userID = homeController.savedDesignDataList[index].userId;
                                                  openedDesignController.designNameControllerOfOd.text = homeController.savedDesignDataList[index].designName!;

                                                  // --------= -=-=-= adding value to lists =-=-=- =--------
                                                  openedDesignController.stickerListFirstImageOfOD.addAll(homeController.savedDesignDataList[index].stickersOfFirstImage!);
                                                  openedDesignController.stickerListSecondImageOfOD.addAll(homeController.savedDesignDataList[index].stickersOfSecondImage!);

                                                  openedDesignController.imageListOfOd.addAll(homeController.savedDesignDataList[index].galleryImagesOfFirstImage!);
                                                  openedDesignController.imageListSecondImageOfOd.addAll(homeController.savedDesignDataList[index].galleryImagesOfSecondImage!);

                                                  openedDesignController.textListOfOd.addAll(homeController.savedDesignDataList[index].textsOfFirstImage!);
                                                  openedDesignController.textListForSecondImageOfOd.addAll(homeController.savedDesignDataList[index].textsOfSecondImage!);

                                                  homeController.popularityCountInt = homeController.savedDesignDataList[index].popularityCount;

                                                  int? popularityCount;
                                                  popularityCount = homeController.popularityCountInt! + 1;

                                                  openedDesignController.update();
                                                  await FirebaseFirestore.instance.collection("NewShirtDesign").doc(openedDesignController.docID).update({
                                                    "popularityCount" : popularityCount,
                                                  });

                                                  Get.to(() => OpenedDesignScreen());

                                                }
                                            ),
                                            SizedBox(width: 60.w,)
                                          ],
                                        );
                                      }),
                                ) : Container(),
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
