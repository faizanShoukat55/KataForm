// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../custom_widgets/image_container.dart';
import 'otp_view_model.dart';

class OptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> OptViewModel(),
    child: Consumer<OptViewModel>(
      builder: (context, model, child)=> Scaffold(

        backgroundColor: backgroundColor,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text("Channab", style: appBarTextStyle),
          backgroundColor: backgroundColor,
          elevation: 0.0,

          actions: [
            ImageContainer(
              width: 26.sp,
              height: 15.sp,
              assets: IconPath.menuIcon,
              radius: 0,
              fit: BoxFit.contain,
            ),

            SizedBox(width: 15.w,),
          ],
        ),


        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.sp, 194.sp, 18.sp, 20.sp),

          child: Center(
            child: Column(
              children: [



                Text("OTP Verification", style: poppinTextStyle.copyWith(
                  color: primaryColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                ),),
                SizedBox(height: 4.h,),

                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Enter the OTP send to ",
                        style: poppinTextStyle.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: "test@email.com",
                            style: poppinTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                        ]
                    ),),

                SizedBox(height: 24.h,),

                ///
                /// Otp Number Text Field
                ///
                Container(
                  width: 300.w,
                  child: PinCodeTextField(

                    backgroundColor: Colors.transparent,
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    enableActiveFill: true,
                    obscuringCharacter: "•",
                    animationType: AnimationType.fade,

                    pinTheme: PinTheme(
                      borderWidth: 0.2,

                      inactiveColor: Colors.white,
                      selectedFillColor: primaryColor,
                      shape: PinCodeFieldShape.box,
                      fieldHeight: 50.h,
                      fieldWidth: 57.w,
                      borderRadius: BorderRadius.circular(5),
                      activeFillColor: primaryColor,
                      inactiveFillColor: Colors.white
                    ),
                    cursorColor: primaryColor,

                    textStyle: TextStyle(fontSize: 20, height: 1.6),
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
//                  model.otp = v ;
//                  print("${model.otp}");
//                  model.signInWithOTP();
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
//                    onChanged: (value) {
//                      model.otp = value;
//                      print("${model.otp}");
//
//                      if(model.otp != null && model.otp.length < 6){
////                        model.authService.signInWithOTP(model.otp, model.verificationId);
//                      }
////                    setState(() {
////                      currentText = value;
////                    });
//                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, onChanged: (String value) {  },
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    ),);
  }
}
