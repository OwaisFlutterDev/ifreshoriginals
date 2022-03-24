import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:ifreshoriginals_userapp/view/widgets/home_screen_widget.dart';

class FeaturedDesignsScreen extends StatelessWidget{
  const FeaturedDesignsScreen({Key? key}) : super(key: key);

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

                GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      // maxCrossAxisExtent: 400.h,
                      crossAxisCount: 3,
                      mainAxisExtent: 440.h,
                    ),
                    itemCount: 25,
                    itemBuilder: (BuildContext ctx, index) {
                      return  savedAndDesignHistoryWidget(
                        image: "https://tinyurl.com/y9ax33uv",
                        name: "Football Love",
                      );
                    }),
              ],),
            ),)),
    );
  }
}