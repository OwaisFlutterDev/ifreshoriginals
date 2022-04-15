import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/create_new_design_screens/create_new_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

import '../../../controller/home_controller.dart';
import '../profile_screens/saved_designs_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   HomeController homeController = Get.put(HomeController());
   OpenedDesignController openedDesignController = Get.put(OpenedDesignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      //-------------------------------------------------
      //     ------ ========== Body ======== ------
      //-------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
               child: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 30.w),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 40.h,),
                     // --- === title === ---
                     commonText(title: "Welcome,\nCreate your own design",
                         textStyle: TextStyle(color: blackColor,fontWeight: FontWeight.bold,fontSize: 65.sp)),

                     //-------------------------------------------------
                     //     ------ ========== Create New Design ======== ------
                     //-------------------------------------------------
                     SizedBox(height: 70.h,),
                     headerThree(title: "Create New Design",color: blackColor,fontWeight: FontWeight.w500),
                     SizedBox(height: 50.h,),
                     GetBuilder<HomeController>(
                       init: HomeController(),
                       builder: (controller) {
                         return Container(
                           height: 420.h,
                           color: Colors.transparent,
                           child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: homeController.createNewDesignList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context,int index){
                              return  Padding(
                                padding:  EdgeInsets.only(right: 50.w),
                                child: createNewDesignWidget(
                                    onTap: () {
                                      homeController.selectedFrontImage =  homeController.createNewDesignList[index].frontImage;
                                      homeController.selectedBackImage =   homeController.createNewDesignList[index].backImage;
                                      homeController.selectedShirtName =   homeController.createNewDesignList[index].title;
                                      homeController.newDesignPrice = 0;
                                      homeController.update();
                                      homeController.newDesignPrice =  homeController.newDesignPrice! + homeController.createNewDesignList[index].shirtPrice!;
                                      homeController.shirtPrice = homeController.createNewDesignList[index].shirtPrice!;
                                      homeController.update();
                                      Get.to(() => CreateNewDesignScreen());
                                    },
                                    image: "${homeController.createNewDesignList[index].frontImage}",
                                    name: "${homeController.createNewDesignList[index].title}"
                                ),
                              );
                            } ),
                         );
                       }
                     ),

                     //-------------------------------------------------------------
                     //     ------ ========== Saved Design Section ======== ------
                     //-------------------------------------------------------------

                     SizedBox(height: 50.h,),
                     // -- == section title == ---
                    Obx(
                       () => homeController.savedDesignDataList.isNotEmpty ? sectionTitleWidget(
                       title: "Saved Designs",
                       onTap: () => Get.to(() => SavedDesignsScreen())
                     ) : Container()),
                     SizedBox(height: 50.h,),

                     Obx(
                           () => Container(
                             color: Colors.transparent,
                             height: 370.h,
                             child: ListView.builder(
                             shrinkWrap: true,
                             physics: ScrollPhysics(),
                             scrollDirection: Axis.horizontal,
                             itemCount: homeController.savedDesignDataList.length,
                             itemBuilder: (context, index) {
                               return  Row(
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

                                           //-=-= payment details =-=-
                                           homeController.newDesignPriceForOD = 0;
                                           homeController.update();
                                           homeController.newDesignPriceForOD =  homeController.newDesignPriceForOD! + homeController.savedDesignDataList[index].totalPrice!;
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
                           ),
                     ),

                     //-------------------------------------------------
                     //     ------ ========== Design History Section ======== ------
                     //-------------------------------------------------
                     // SizedBox(height: 90.h,),
                     // // -- == section title == ---
                     // sectionTitleWidget(
                     //     title: "Design History",
                     //     onTap: () => Get.to(() => DesignsHistoryScreen())
                     // ),
                     // SizedBox(height: 50.h,),
                     // Row(
                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     //   children: [
                     //     savedAndDesignHistoryWidget(
                     //       image: "https://tinyurl.com/y9ax33uv",
                     //     ),
                     //     savedAndDesignHistoryWidget(
                     //       image: "https://tinyurl.com/ybp5syc4",
                     //     ),
                     //     savedAndDesignHistoryWidget(
                     //       image: "https://tinyurl.com/y8hy8lal",
                     //     ),
                     //   ],
                     // ),

                           ],),
               )),),
    );
  }



}