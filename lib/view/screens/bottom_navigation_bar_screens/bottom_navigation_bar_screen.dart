import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/constants.dart';
import '../../../controller/bottom_navigation_bar_controller.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/home_screen_widget.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  final controller=Get.put(BottomNavigationBarController());
    BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      //-------------------------------------------------
      //     ------ ========== AppBar ======== ------
      //-------------------------------------------------
      appBar: AppBar(
        title: GetBuilder<BottomNavigationBarController>(
            builder: (_) {
            return commonText(
                title: controller.selectedIndex == 0 ? "Home" :
                controller.selectedIndex == 1 ? "Explore" : "Profile"
                ,textStyle:
            TextStyle(color: Colors.black,fontSize: 50.sp,fontWeight: FontWeight.w500)
            );
          }
        ),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading:  Builder(
          builder: (context) =>   InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Row(
              children: [

                SizedBox(width: 40.w,),
                Container(
                  height: 90.h,
                  width: 90.w,
                  color: Colors.transparent,
                  child: Image(image: AssetImage("assets/Top Bar.png"),
                    color: blackColor, fit: BoxFit.scaleDown,),
                ),
              ],
            ),
          ),
        ),
          // onPressed: () => Scaffold.of(context).openDrawer(),


        actions: [
          cartButtonWidget(),
          SizedBox(width: 40.w,)
        ]
        // leadingWidth: 200.w,
      ),

      //-------------------------------------------------
      //     ------ ========== Drawer ======== ------
      //-------------------------------------------------
      drawer: Drawer(
        backgroundColor: bgColor,
        child: drawerWidget(),
      ),

      //-------------------------------------------------
      //     ------ ========== Body ======== ------
      //-------------------------------------------------

      body: GetBuilder<BottomNavigationBarController>(

          builder: (controller) {
          return Center(
            child: controller.pages.elementAt(controller.selectedIndex!), //New
          );
        }
      ),

      bottomNavigationBar: GetBuilder<BottomNavigationBarController>(
        builder: (controller) {
          return BottomNavigationBar(

            selectedIconTheme: IconThemeData(color: redColor, size: 100.sp),
            selectedItemColor: redColor,
            elevation: 0,

            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(

                icon: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.h),
                  child: Image(image: AssetImage("assets/Shape.png"),
                      height: controller.selectedIndex == 0 ? 90.h : 85.w,
                      width: controller.selectedIndex == 0 ? 90.h : 85.w,
                      color: controller.selectedIndex == 0 ? redColor : lightGrayColor ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.h),
                  child: Image(image: AssetImage("assets/Asset 27.png"),
                      height: controller.selectedIndex == 1 ? 90.h : 85.w,
                      width: controller.selectedIndex == 1 ? 90.h : 85.w,
                      color: controller.selectedIndex == 1 ? redColor : lightGrayColor),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.h),
                  child: Image(image: AssetImage("assets/Asset 28.png"),
                      height: controller.selectedIndex == 2 ? 90.h : 85.w,
                      width: controller.selectedIndex == 2 ? 90.h : 85.w,
                      color: controller.selectedIndex == 2 ? redColor : lightGrayColor ),
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: controller.selectedIndex!, //New
            onTap: controller.onItemTapped,
          );
        }
      ),
    );
  }
}