// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/services/auth_services.dart';
import '../../../locator.dart';
import '../animals_list/animal_list_screen.dart';
import '../authentication/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = locator<AuthService>();

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(Duration(seconds: 3));
    if (authService.isLogin! && authService.appUser != null) {
      Get.to(() => HomeScreen());
    } else {
      Get.to(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Channab", style: poppinTextStyle.copyWith(
              color: primaryColor
            ),),

            SizedBox(height: 20.h,),


            CircularProgressIndicator(
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
