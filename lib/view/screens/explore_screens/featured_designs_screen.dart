import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/home_controller.dart';
import 'package:ifreshoriginals_userapp/controller/opened_design_controller.dart';
import 'package:ifreshoriginals_userapp/model/create_new_design_models.dart';
import 'package:ifreshoriginals_userapp/view/screens/opened_design_screens/opened_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

class FeaturedDesignsScreen extends StatelessWidget{
   FeaturedDesignsScreen({Key? key}) : super(key: key);

   final HomeController homeController  = Get.find<HomeController>();
   final OpenedDesignController  openedDesignController = Get.put(OpenedDesignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      //-------------------------------------------------
      //     ------ ========== App Bar ======== ------
      //-------------------------------------------------

      appBar: appBar(
          title: "Featured Designs",
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
            FirebaseAuth.instance.currentUser!.isAnonymous ? Container() : cartButtonWidget(),
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

                FirestoreQueryBuilder<NewShirtDesignModel>(
                  query: homeController.featuredDesignQuery,
                  pageSize: 2,
                  builder: (context, snapshot, _) {
                    if (snapshot.isFetching) {
                      return const CircularProgressIndicator();
                    }
                    else if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else {
                      return GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                      // maxCrossAxisExtent: 400.h,
                                      crossAxisCount: 3,
                                      mainAxisExtent: 440.h,
                                    ),
                                    itemCount: snapshot.docs.length,
                                    itemBuilder: (BuildContext ctx, index) {

                                      // if we reached the end of the currently obtained items, we try to
                                      // obtain more items
                                      if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                        // Tell FirestoreQueryBuilder to try to obtain more items.
                                        // It is safe to call this function from within the build method.
                                        snapshot.fetchMore();
                                      }

                                      final data = snapshot.docs[index].data();

                                      return  savedAndDesignHistoryWidget(
                                          image: data.frontImageOfDesign,
                                          name: data.designName,
                                          onTap: () async {

                                            homeController.selectedFrontImageOfOpenedDesign =  data.frontImage;
                                            homeController.selectedBackImageOfOpenedDesign =   data.backImage;
                                            homeController.selectedShirtNameOfOpenedDesign =   data.designName;
                                            homeController.selectedShirtTypeOfOpenedDesign =   data.shirtType;
                                            homeController.update();


                                            openedDesignController.selectedColorsForShirt = data.firstShirtColor;
                                            openedDesignController.hexToColor();
                                            openedDesignController.selectedColorsForShirtSecondImage = data.secondShirtColor;
                                            openedDesignController.hexToColorForSecondShort();

                                            homeController.newDesignPrice = 0;
                                            homeController.update();
                                            homeController.newDesignPrice =  homeController.newDesignPrice! + data.totalPrice!;
                                            homeController.update();


                                            // --------= -=-=-= clear lists =-=-=- =--------
                                            openedDesignController.stickerListFirstImageOfOD.clear();
                                            openedDesignController.stickerListSecondImageOfOD.clear();
                                            openedDesignController.imageListOfOd.clear();
                                            openedDesignController.imageListSecondImageOfOd.clear();
                                            openedDesignController.textListOfOd.clear();
                                            openedDesignController.textListForSecondImageOfOd.clear();

                                            openedDesignController.docID = data.id;
                                            openedDesignController.userID = data.userId;
                                            openedDesignController.designNameControllerOfOd.text = data.designName!;

                                            // --------= -=-=-= adding value to lists =-=-=- =--------
                                            openedDesignController.stickerListFirstImageOfOD.addAll(data.stickersOfFirstImage!);
                                            openedDesignController.stickerListSecondImageOfOD.addAll(data.stickersOfSecondImage!);

                                            openedDesignController.imageListOfOd.addAll(data.galleryImagesOfFirstImage!);
                                            openedDesignController.imageListSecondImageOfOd.addAll(data.galleryImagesOfSecondImage!);

                                            openedDesignController.textListOfOd.addAll(data.textsOfFirstImage!);
                                            openedDesignController.textListForSecondImageOfOd.addAll(data.textsOfSecondImage!);

                                            homeController.popularityCountInt = data.popularityCount;

                                            int? popularityCount;
                                            popularityCount = homeController.popularityCountInt! + 1;

                                            openedDesignController.update();
                                            await FirebaseFirestore.instance.collection("NewShirtDesign").doc(openedDesignController.docID).update({
                                              "popularityCount" : popularityCount,
                                            });

                                            Get.to(() => OpenedDesignScreen());


                                          }
                                      );
                                    },
                      );}

                  },
                )

               // Obx(
               //        () =>
               //        GridView.builder(
               //            scrollDirection: Axis.vertical,
               //            physics: ScrollPhysics(),
               //            shrinkWrap: true,
               //            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
               //              // maxCrossAxisExtent: 400.h,
               //              crossAxisCount: 3,
               //              mainAxisExtent: 440.h,
               //            ),
               //            itemCount: homeController.featuredDesignDataList.length,
               //            itemBuilder: (BuildContext ctx, index) {
               //              return  savedAndDesignHistoryWidget(
               //                  image: homeController.featuredDesignDataList[index].frontImageOfDesign,
               //                  name: homeController.featuredDesignDataList[index].designName,
               //                  onTap: () async {
               //
               //                    homeController.selectedFrontImageOfOpenedDesign =  homeController.featuredDesignDataList[index].frontImage;
               //                    homeController.selectedBackImageOfOpenedDesign =   homeController.featuredDesignDataList[index].backImage;
               //                    homeController.selectedShirtNameOfOpenedDesign =   homeController.featuredDesignDataList[index].designName;
               //                    homeController.selectedShirtTypeOfOpenedDesign =   homeController.featuredDesignDataList[index].shirtType;
               //                    homeController.update();
               //
               //
               //                    openedDesignController.selectedColorsForShirt = homeController.featuredDesignDataList[index].firstShirtColor;
               //                    openedDesignController.hexToColor();
               //                    openedDesignController.selectedColorsForShirtSecondImage = homeController.featuredDesignDataList[index].secondShirtColor;
               //                    openedDesignController.hexToColorForSecondShort();
               //
               //                    homeController.newDesignPrice = 0;
               //                    homeController.update();
               //                    homeController.newDesignPrice =  homeController.newDesignPrice! + homeController.featuredDesignDataList[index].totalPrice!;
               //                    homeController.update();
               //
               //
               //                    // --------= -=-=-= clear lists =-=-=- =--------
               //                    openedDesignController.stickerListFirstImageOfOD.clear();
               //                    openedDesignController.stickerListSecondImageOfOD.clear();
               //                    openedDesignController.imageListOfOd.clear();
               //                    openedDesignController.imageListSecondImageOfOd.clear();
               //                    openedDesignController.textListOfOd.clear();
               //                    openedDesignController.textListForSecondImageOfOd.clear();
               //
               //                    openedDesignController.docID = homeController.featuredDesignDataList[index].id;
               //                    openedDesignController.userID = homeController.featuredDesignDataList[index].userId;
               //                    openedDesignController.designNameControllerOfOd.text = homeController.featuredDesignDataList[index].designName!;
               //
               //                    // --------= -=-=-= adding value to lists =-=-=- =--------
               //                    openedDesignController.stickerListFirstImageOfOD.addAll(homeController.featuredDesignDataList[index].stickersOfFirstImage!);
               //                    openedDesignController.stickerListSecondImageOfOD.addAll(homeController.featuredDesignDataList[index].stickersOfSecondImage!);
               //
               //                    openedDesignController.imageListOfOd.addAll(homeController.featuredDesignDataList[index].galleryImagesOfFirstImage!);
               //                    openedDesignController.imageListSecondImageOfOd.addAll(homeController.featuredDesignDataList[index].galleryImagesOfSecondImage!);
               //
               //                    openedDesignController.textListOfOd.addAll(homeController.featuredDesignDataList[index].textsOfFirstImage!);
               //                    openedDesignController.textListForSecondImageOfOd.addAll(homeController.featuredDesignDataList[index].textsOfSecondImage!);
               //
               //                    homeController.popularityCountInt = homeController.featuredDesignDataList[index].popularityCount;
               //
               //                    int? popularityCount;
               //                    popularityCount = homeController.popularityCountInt! + 1;
               //
               //                    openedDesignController.update();
               //                    await FirebaseFirestore.instance.collection("NewShirtDesign").doc(openedDesignController.docID).update({
               //                      "popularityCount" : popularityCount,
               //                    });
               //
               //                    Get.to(() => OpenedDesignScreen());
               //
               //
               //                  }
               //              );
               //            }),
               //  ),
              ],),
            ),)),
    );
  }
}