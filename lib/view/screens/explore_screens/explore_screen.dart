import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/explore_screens/all_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/explore_screens/featured_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/explore_screens/popular_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/home_screen_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  HomeController homeController  = Get.find<HomeController>();
  OpenedDesignController  openedDesignController = Get.put(OpenedDesignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //-------------------------------------------------
                          //     ------ ========== Popular Designs section ======== ------
                          //-------------------------------------------------
                          SizedBox(height: 50.h,),
                          // -- == section title == ---
                          Obx(
                                  () => homeController.popularDesignLimitedDataList.isNotEmpty ? sectionTitleWidget(
                                  title: "Popular Designs",
                                  onTap: () => Get.to(() => PopularDesignsScreen())
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
                                  itemCount: homeController.popularDesignLimitedDataList.length,
                                  itemBuilder: (context, index)  {
                                    return  Row(
                                      children: [
                                        savedAndDesignHistoryWidget(
                                            image: homeController.popularDesignLimitedDataList[index].frontImageOfDesign,
                                            name: homeController.popularDesignLimitedDataList[index].designName,
                                            onTap: () async {

                                              homeController.selectedFrontImageOfOpenedDesign =  homeController.popularDesignLimitedDataList[index].frontImage;
                                              homeController.selectedBackImageOfOpenedDesign =   homeController.popularDesignLimitedDataList[index].backImage;
                                              homeController.selectedShirtNameOfOpenedDesign =   homeController.popularDesignLimitedDataList[index].designName;
                                              homeController.selectedShirtTypeOfOpenedDesign =   homeController.popularDesignLimitedDataList[index].shirtType;
                                              homeController.update();


                                              openedDesignController.selectedColorsForShirt = homeController.popularDesignLimitedDataList[index].firstShirtColor;
                                              openedDesignController.hexToColor();
                                              openedDesignController.selectedColorsForShirtSecondImage = homeController.popularDesignLimitedDataList[index].secondShirtColor;
                                              openedDesignController.hexToColorForSecondShort();

                                              // --------= -=-=-= clear lists =-=-=- =--------
                                              openedDesignController.stickerListFirstImageOfOD.clear();
                                              openedDesignController.stickerListSecondImageOfOD.clear();
                                              openedDesignController.imageListOfOd.clear();
                                              openedDesignController.imageListSecondImageOfOd.clear();
                                              openedDesignController.textListOfOd.clear();
                                              openedDesignController.textListForSecondImageOfOd.clear();

                                              openedDesignController.docID = homeController.popularDesignLimitedDataList[index].id;
                                              openedDesignController.userID = homeController.popularDesignLimitedDataList[index].userId;
                                              openedDesignController.designNameControllerOfOd.text = homeController.popularDesignLimitedDataList[index].designName!;

                                              // --------= -=-=-= adding value to lists =-=-=- =--------
                                              openedDesignController.stickerListFirstImageOfOD.addAll(homeController.popularDesignLimitedDataList[index].stickersOfFirstImage!);
                                              openedDesignController.stickerListSecondImageOfOD.addAll(homeController.popularDesignLimitedDataList[index].stickersOfSecondImage!);

                                              openedDesignController.imageListOfOd.addAll(homeController.popularDesignLimitedDataList[index].galleryImagesOfFirstImage!);
                                              openedDesignController.imageListSecondImageOfOd.addAll(homeController.popularDesignLimitedDataList[index].galleryImagesOfSecondImage!);

                                              openedDesignController.textListOfOd.addAll(homeController.popularDesignLimitedDataList[index].textsOfFirstImage!);
                                              openedDesignController.textListForSecondImageOfOd.addAll(homeController.popularDesignLimitedDataList[index].textsOfSecondImage!);

                                              homeController.popularityCountInt = homeController.popularDesignLimitedDataList[index].popularityCount;

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
                          //     ------ ========== Featured Designs section ======== ------
                          //-------------------------------------------------
                          SizedBox(height: 90.h,),
                          // -- == section title == ---

                          Obx(
                                  () => homeController.featuredDesignLimitedDataList.isNotEmpty ? sectionTitleWidget(
                                  title: "Featured Designs",
                                  onTap: () => Get.to(() => FeaturedDesignsScreen())
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
                                  itemCount: homeController.featuredDesignLimitedDataList.length,
                                  itemBuilder: (context, index) {
                                    return  Row(
                                      children: [
                                        savedAndDesignHistoryWidget(
                                            image: homeController.featuredDesignLimitedDataList[index].frontImageOfDesign,
                                            name: homeController.featuredDesignLimitedDataList[index].designName,
                                            onTap: () async {

                                              homeController.selectedFrontImageOfOpenedDesign =  homeController.featuredDesignLimitedDataList[index].frontImage;
                                              homeController.selectedBackImageOfOpenedDesign =   homeController.featuredDesignLimitedDataList[index].backImage;
                                              homeController.selectedShirtNameOfOpenedDesign =   homeController.featuredDesignLimitedDataList[index].designName;
                                              homeController.selectedShirtTypeOfOpenedDesign =   homeController.featuredDesignLimitedDataList[index].shirtType;
                                              homeController.update();


                                              openedDesignController.selectedColorsForShirt = homeController.featuredDesignLimitedDataList[index].firstShirtColor;
                                              openedDesignController.hexToColor();
                                              openedDesignController.selectedColorsForShirtSecondImage = homeController.featuredDesignLimitedDataList[index].secondShirtColor;
                                              openedDesignController.hexToColorForSecondShort();

                                              // --------= -=-=-= clear lists =-=-=- =--------
                                              openedDesignController.stickerListFirstImageOfOD.clear();
                                              openedDesignController.stickerListSecondImageOfOD.clear();
                                              openedDesignController.imageListOfOd.clear();
                                              openedDesignController.imageListSecondImageOfOd.clear();
                                              openedDesignController.textListOfOd.clear();
                                              openedDesignController.textListForSecondImageOfOd.clear();

                                              openedDesignController.docID = homeController.featuredDesignLimitedDataList[index].id;
                                              openedDesignController.userID = homeController.featuredDesignLimitedDataList[index].userId;
                                              openedDesignController.designNameControllerOfOd.text = homeController.featuredDesignLimitedDataList[index].designName!;

                                              // --------= -=-=-= adding value to lists =-=-=- =--------
                                              openedDesignController.stickerListFirstImageOfOD.addAll(homeController.featuredDesignLimitedDataList[index].stickersOfFirstImage!);
                                              openedDesignController.stickerListSecondImageOfOD.addAll(homeController.featuredDesignLimitedDataList[index].stickersOfSecondImage!);

                                              openedDesignController.imageListOfOd.addAll(homeController.featuredDesignLimitedDataList[index].galleryImagesOfFirstImage!);
                                              openedDesignController.imageListSecondImageOfOd.addAll(homeController.featuredDesignLimitedDataList[index].galleryImagesOfSecondImage!);

                                              openedDesignController.textListOfOd.addAll(homeController.featuredDesignLimitedDataList[index].textsOfFirstImage!);
                                              openedDesignController.textListForSecondImageOfOd.addAll(homeController.featuredDesignLimitedDataList[index].textsOfSecondImage!);

                                              homeController.popularityCountInt = homeController.featuredDesignLimitedDataList[index].popularityCount;

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
                          //     ------ ========== All Designs Section ======== ------
                          //-------------------------------------------------
                          SizedBox(height: 90.h,),
                          // -- == section title == ---
                          Obx(
                                  () => homeController.allDesignLimitedDataList.isNotEmpty ? sectionTitleWidget(
                                  title: "All Designs",
                                  onTap: () => Get.to(() => AllDesignsScreen())
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
                                  itemCount: homeController.allDesignLimitedDataList.length,
                                  itemBuilder: (context, index) {
                                    return  Row(
                                      children: [
                                        savedAndDesignHistoryWidget(
                                            image: homeController.allDesignLimitedDataList[index].frontImageOfDesign,
                                            name: homeController.allDesignLimitedDataList[index].designName,
                                            onTap: ()  async {

                                              homeController.selectedFrontImageOfOpenedDesign =  homeController.allDesignLimitedDataList[index].frontImage;
                                              homeController.selectedBackImageOfOpenedDesign =   homeController.allDesignLimitedDataList[index].backImage;
                                              homeController.selectedShirtNameOfOpenedDesign =   homeController.allDesignLimitedDataList[index].designName;
                                              homeController.selectedShirtTypeOfOpenedDesign =   homeController.allDesignLimitedDataList[index].shirtType;
                                              homeController.update();


                                              openedDesignController.selectedColorsForShirt = homeController.allDesignLimitedDataList[index].firstShirtColor;
                                              openedDesignController.hexToColor();
                                              openedDesignController.selectedColorsForShirtSecondImage = homeController.allDesignLimitedDataList[index].secondShirtColor;
                                              openedDesignController.hexToColorForSecondShort();

                                              // --------= -=-=-= clear lists =-=-=- =--------
                                              openedDesignController.stickerListFirstImageOfOD.clear();
                                              openedDesignController.stickerListSecondImageOfOD.clear();
                                              openedDesignController.imageListOfOd.clear();
                                              openedDesignController.imageListSecondImageOfOd.clear();
                                              openedDesignController.textListOfOd.clear();
                                              openedDesignController.textListForSecondImageOfOd.clear();

                                              openedDesignController.docID = homeController.allDesignLimitedDataList[index].id;
                                              openedDesignController.userID = homeController.allDesignLimitedDataList[index].userId;
                                              openedDesignController.designNameControllerOfOd.text = homeController.allDesignLimitedDataList[index].designName!;

                                              // --------= -=-=-= adding value to lists =-=-=- =--------
                                              openedDesignController.stickerListFirstImageOfOD.addAll(homeController.allDesignLimitedDataList[index].stickersOfFirstImage!);
                                              openedDesignController.stickerListSecondImageOfOD.addAll(homeController.allDesignLimitedDataList[index].stickersOfSecondImage!);

                                              openedDesignController.imageListOfOd.addAll(homeController.allDesignLimitedDataList[index].galleryImagesOfFirstImage!);
                                              openedDesignController.imageListSecondImageOfOd.addAll(homeController.allDesignLimitedDataList[index].galleryImagesOfSecondImage!);

                                              openedDesignController.textListOfOd.addAll(homeController.allDesignLimitedDataList[index].textsOfFirstImage!);
                                              openedDesignController.textListForSecondImageOfOd.addAll(homeController.allDesignLimitedDataList[index].textsOfSecondImage!);

                                              homeController.popularityCountInt = homeController.allDesignLimitedDataList[index].popularityCount;

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
          ],
        ),
              )),
      ),
    );
  }
}
