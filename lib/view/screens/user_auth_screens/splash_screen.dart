import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/controller/shared_preferences_controller.dart';
import 'package:ifreshoriginals_userapp/controller/user_profile_controller.dart';
import 'package:ifreshoriginals_userapp/view/screens/bottom_navigation_bar_screens/bottom_navigation_bar_screen.dart';
import 'package:ifreshoriginals_userapp/view/screens/user_auth_screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:ifreshoriginals_userapp/view/widgets/user_auth_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferencesController controller = Get.put(SharedPreferencesController());
  final UserProfileController profileController = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();

    controller.getUserData().whenComplete(() async {
      Timer(Duration(seconds: 4), () async {
        controller.checkUser != null ? await profileController.getUserData() : null ;
        Get.offAll(() => controller.checkUser == null ? WelcomeScreen(): BottomNavigationBarScreen()
        );
      });
    } );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1D1D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        //   --------------- ==== Image === --------------
        Center(
          child: imageWidget(
              image: "assets/Asset 1.png",
              height: 700.h,
              width: 700.w),
        )
      ],),
    );
  }
}