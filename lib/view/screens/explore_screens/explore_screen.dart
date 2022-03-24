import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/constant/constants.dart';
import 'package:ifreshoriginals_userapp/view/screens/explore_screens/all_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/explore_screens/featured_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/explore_screens/popular_designs_screen.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/home_screen_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

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
                          sectionTitleWidget(
                              title: "Popular Designs",
                              onTap: () => Get.to(() => PopularDesignsScreen())
                          ),
                          SizedBox(height: 50.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              savedAndDesignHistoryWidget(
                                image: "https://tinyurl.com/y9ax33uv",
                                name: "Wanted",
                              ),
                              savedAndDesignHistoryWidget(
                                image: "https://tinyurl.com/ybp5syc4",
                                name: "NYC",
                              ),
                              savedAndDesignHistoryWidget(
                                image: "https://tinyurl.com/y8hy8lal",
                                name: "Stranger",
                              ),
                            ],
                          ),

                          //-------------------------------------------------
                          //     ------ ========== Featured Designs section ======== ------
                          //-------------------------------------------------
                          SizedBox(height: 90.h,),
                          // -- == section title == ---
                          sectionTitleWidget(
                              title: "Featured Designs",
                              onTap: () => Get.to(() => FeaturedDesignsScreen())
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
                          //     ------ ========== All Designs Section ======== ------
                          //-------------------------------------------------
                          SizedBox(height: 90.h,),
                          // -- == section title == ---
                          sectionTitleWidget(
                              title: "All Designs",
                              onTap: () => Get.to(() => AllDesignsScreen())
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
          ],
        ),
              )),
      ),
    );
  }
}
