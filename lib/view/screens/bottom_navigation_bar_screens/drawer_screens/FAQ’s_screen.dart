import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';

import '../../../widgets/common_widgets.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: "FAQs",
          leadingWidget: InkWell(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back,color: blackColor,size: 70.r),
          )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      largeText(
                        title: "Lorem ipsum dolor",
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Wrap(
                    children: [
                      smallText(
                          title: "Lorem ipsum dolor sit amet, consectetur adipis cing elit. Etiam odio est, laoreet vitae dictum ac, accumsan vitae erat. Nullam et hendrerit nulla, vel dapibus dolor. Aliquam malesuada at orci vitae dapibus. Fusce rutrum magna id lacus tristi que, sit amet efficitur ligula maximus."
                      ),
                    ],
                  ),


                  SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      largeText(
                        title: "Lorem ipsum dolor",
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Wrap(
                    children: [
                      smallText(
                          title: "Lorem ipsum dolor sit amet, consectetur adipis cing elit. Etiam odio est, laoreet vitae dictum ac, accumsan vitae erat. Nullam et hendrerit nulla, vel dapibus dolor. Aliquam malesuada at orci vitae dapibus. Fusce rutrum magna id lacus tristi que, sit amet efficitur ligula maximus."
                      ),
                    ],
                  ),


                  SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      largeText(
                        title: "Lorem ipsum dolor",
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Wrap(
                    children: [
                      smallText(
                          title: "Lorem ipsum dolor sit amet, consectetur adipis cing elit. Etiam odio est, laoreet vitae dictum ac, accumsan vitae erat. Nullam et hendrerit nulla, vel dapibus dolor. Aliquam malesuada at orci vitae dapibus. Fusce rutrum magna id lacus tristi que, sit amet efficitur ligula maximus."
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
