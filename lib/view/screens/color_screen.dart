import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:ifreshoriginals_userapp/view/widgets/common_widgets.dart';


class ScreenPre extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            children: [
               SizedBox(height: 20.h,),
               commonText(
                 title: "Hello EveryOne",
                 textStyle: TextStyle(
                   fontSize: 70.sp,
                   fontWeight: FontWeight.w700
                 ),
               ),

          ],),
        ),
      ),
    );
  }
}