
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/view/screens/home_screens/home_screen.dart';

import '../view/screens/explore_screens/explore_screen.dart';
import '../view/screens/profile_screens/profile_screen.dart';

class BottomNavigationBarController extends GetxController {

  int? selectedIndex = 0;



  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  List<Widget> pages = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];

}