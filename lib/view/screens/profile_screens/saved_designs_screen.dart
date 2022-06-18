import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/functionality_on_opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

class SavedDesignsScreen extends StatelessWidget{
  SavedDesignsScreen({Key? key}) : super(key: key);

   final HomeController homeController  = Get.find<HomeController>();
   final OpenedDesignController  openedDesignController = Get.put(OpenedDesignController());
  final FunctionalityOnOpenedDesignController functionalityOnOpenedDesignController = Get.put(FunctionalityOnOpenedDesignController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      //-------------------------------------------------
      //     ------ ========== App Bar ======== ------
      //-------------------------------------------------

      appBar:    appBar(
        title: "Saved Designs",
        leadingWidget: InkWell(
          onTap: () {

            // Get.to(() => BottomNavigationBarScreen());
            Get.back();

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.w,),
              Icon(CupertinoIcons.back,color: blackColor,size: 90.r),
            ],
          ),
        ),
        action: [
          FirebaseAuth.instance.currentUser!.isAnonymous ? Container() : cartButtonWidget(),
          SizedBox(width: 40.w,)
        ]
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(children: [
                   SizedBox(height: 40.h,),
              Obx(
                    () =>
                GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        // maxCrossAxisExtent: 400.h,
                        crossAxisCount: 3,
                        mainAxisExtent: 440.h,
                    ),
                    itemCount: homeController.savedDesignAllDataList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return  savedAndDesignHistoryWidget(
                          image: homeController.savedDesignAllDataList[index].frontImageOfDesign,
                          name: homeController.savedDesignAllDataList[index].designName,
                          onTap: () async {
                            functionalityOnOpenedDesignController.imageSideOfOIBool = false;
                            homeController.selectedFrontImageOfOpenedDesign =  homeController.savedDesignAllDataList[index].frontImage;
                            homeController.selectedBackImageOfOpenedDesign =   homeController.savedDesignAllDataList[index].backImage;
                            homeController.selectedShirtNameOfOpenedDesign =   homeController.savedDesignAllDataList[index].designName;
                            homeController.selectedShirtTypeOfOpenedDesign =   homeController.savedDesignAllDataList[index].shirtType;
                            homeController.update();

                            openedDesignController.selectedColorsForShirt = homeController.savedDesignAllDataList[index].firstShirtColor;
                            openedDesignController.hexToColor();
                            openedDesignController.selectedColorsForShirtSecondImage = homeController.savedDesignAllDataList[index].secondShirtColor;
                            openedDesignController.hexToColorForSecondShort();

                            //-=-= payment details =-=-
                            homeController.newDesignPrice = 0;
                            homeController.update();
                            homeController.newDesignPrice =  homeController.newDesignPrice! + homeController.savedDesignDataList[index].totalPrice!;
                            homeController.update();

                            // --------= -=-=-= clear lists =-=-=- =--------
                            openedDesignController.stickerListFirstImageOfOD.clear();
                            openedDesignController.stickerListSecondImageOfOD.clear();
                            openedDesignController.imageListOfOd.clear();
                            openedDesignController.imageListSecondImageOfOd.clear();
                            openedDesignController.textListOfOd.clear();
                            openedDesignController.textListForSecondImageOfOd.clear();

                            openedDesignController.docID = homeController.savedDesignAllDataList[index].id;
                            openedDesignController.userID = homeController.savedDesignAllDataList[index].userId;
                            openedDesignController.designNameControllerOfOd.text = homeController.savedDesignAllDataList[index].designName!;

                            // --------= -=-=-= adding value to lists =-=-=- =--------
                            openedDesignController.stickerListFirstImageOfOD.addAll(homeController.savedDesignAllDataList[index].stickersOfFirstImage!);
                            openedDesignController.stickerListSecondImageOfOD.addAll(homeController.savedDesignAllDataList[index].stickersOfSecondImage!);

                            openedDesignController.imageListOfOd.addAll(homeController.savedDesignAllDataList[index].galleryImagesOfFirstImage!);
                            openedDesignController.imageListSecondImageOfOd.addAll(homeController.savedDesignAllDataList[index].galleryImagesOfSecondImage!);

                            openedDesignController.textListOfOd.addAll(homeController.savedDesignAllDataList[index].textsOfFirstImage!);
                            openedDesignController.textListForSecondImageOfOd.addAll(homeController.savedDesignAllDataList[index].textsOfSecondImage!);

                            homeController.popularityCountInt = homeController.savedDesignAllDataList[index].popularityCount;

                            int? popularityCount;
                            popularityCount = homeController.popularityCountInt! + 1;

                            openedDesignController.update();
                            await FirebaseFirestore.instance.collection("NewShirtDesign").doc(openedDesignController.docID).update({
                              "popularityCount" : popularityCount,
                            });

                            Get.to(() => OpenedDesignScreen());

                          }
                      );
                    }),
              ),
              ],),
            ),)),
    );
  }
}