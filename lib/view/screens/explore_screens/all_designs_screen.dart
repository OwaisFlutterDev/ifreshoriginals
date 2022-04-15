import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

class AllDesignsScreen extends StatelessWidget{
  AllDesignsScreen({Key? key}) : super(key: key);

  HomeController homeController  = Get.find<HomeController>();
  OpenedDesignController  openedDesignController = Get.put(OpenedDesignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      //-------------------------------------------------
      //     ------ ========== App Bar ======== ------
      //-------------------------------------------------

      appBar: appBar(
          title: "All Designs",
          leadingWidget: InkWell(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10.w,),
                Icon(CupertinoIcons.back,color: blackColor,size: 90.r),
              ],
            ),
          ),
          action: [
            cartButtonWidget(),
            SizedBox(width: 40.w,)
          ]
      ),

      //-------------------------------------------------
      //     ------ ========== App Bar ======== ------
      //-------------------------------------------------
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
                          itemCount: homeController.allDesignDataList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return  savedAndDesignHistoryWidget(
                                image: homeController.allDesignDataList[index].frontImageOfDesign,
                                name: homeController.allDesignDataList[index].designName,
                                onTap: () async {

                                  homeController.selectedFrontImageOfOpenedDesign =  homeController.allDesignDataList[index].frontImage;
                                  homeController.selectedBackImageOfOpenedDesign =   homeController.allDesignDataList[index].backImage;
                                  homeController.selectedShirtNameOfOpenedDesign =   homeController.allDesignDataList[index].designName;
                                  homeController.selectedShirtTypeOfOpenedDesign =   homeController.allDesignDataList[index].shirtType;
                                  homeController.update();


                                  openedDesignController.selectedColorsForShirt = homeController.allDesignDataList[index].firstShirtColor;
                                  openedDesignController.hexToColor();
                                  openedDesignController.selectedColorsForShirtSecondImage = homeController.allDesignDataList[index].secondShirtColor;
                                  openedDesignController.hexToColorForSecondShort();

                                  homeController.newDesignPriceForOD = 0;
                                  homeController.update();
                                  homeController.newDesignPriceForOD =  homeController.newDesignPriceForOD! + homeController.allDesignDataList[index].totalPrice!;
                                  homeController.update();

                                  // --------= -=-=-= clear lists =-=-=- =--------
                                  openedDesignController.stickerListFirstImageOfOD.clear();
                                  openedDesignController.stickerListSecondImageOfOD.clear();
                                  openedDesignController.imageListOfOd.clear();
                                  openedDesignController.imageListSecondImageOfOd.clear();
                                  openedDesignController.textListOfOd.clear();
                                  openedDesignController.textListForSecondImageOfOd.clear();

                                  openedDesignController.docID = homeController.allDesignDataList[index].id;
                                  openedDesignController.userID = homeController.allDesignDataList[index].userId;
                                  openedDesignController.designNameControllerOfOd.text = homeController.allDesignDataList[index].designName!;

                                  // --------= -=-=-= adding value to lists =-=-=- =--------
                                  openedDesignController.stickerListFirstImageOfOD.addAll(homeController.allDesignDataList[index].stickersOfFirstImage!);
                                  openedDesignController.stickerListSecondImageOfOD.addAll(homeController.allDesignDataList[index].stickersOfSecondImage!);

                                  openedDesignController.imageListOfOd.addAll(homeController.allDesignDataList[index].galleryImagesOfFirstImage!);
                                  openedDesignController.imageListSecondImageOfOd.addAll(homeController.allDesignDataList[index].galleryImagesOfSecondImage!);

                                  openedDesignController.textListOfOd.addAll(homeController.allDesignDataList[index].textsOfFirstImage!);
                                  openedDesignController.textListForSecondImageOfOd.addAll(homeController.allDesignDataList[index].textsOfSecondImage!);

                                  homeController.popularityCountInt = homeController.allDesignDataList[index].popularityCount;

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