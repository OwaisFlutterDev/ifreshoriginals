import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/controller/create_new_design_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/create_new_design_screens/create_new_design_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/home_screens/design_history_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

import '../../../controller/home_controller.dart';
import '../profile_screens/saved_designs_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
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
                                      homeController.selectedBackImage =  homeController.createNewDesignList[index].backImage;
                                      homeController.selectedShirtName =  homeController.createNewDesignList[index].title;
                                      controller.update();
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

                     SizedBox(height: 50.h,),
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

                     //-------------------------------------------------
                     //     ------ ========== Design History Section ======== ------
                     //-------------------------------------------------
                     SizedBox(height: 90.h,),
                     // -- == section title == ---
                     sectionTitleWidget(
                         title: "Design History",
                         onTap: () => Get.to(() => DesignsHistoryScreen())
                     ),
                     SizedBox(height: 50.h,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         savedAndDesignHistoryWidget(
                           image: "https://tinyurl.com/y9ax33uv",
                         ),
                         savedAndDesignHistoryWidget(
                           image: "https://tinyurl.com/ybp5syc4",
                         ),
                         savedAndDesignHistoryWidget(
                           image: "https://tinyurl.com/y8hy8lal",
                         ),
                       ],
                     ),

                           ],),
               )),),
    );
  }



}