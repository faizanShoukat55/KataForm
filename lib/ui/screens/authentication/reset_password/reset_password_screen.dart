// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katta_form/ui/screens/authentication/reset_password/reset_password_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../custom_widgets/button/rounded_button.dart';
import '../../../custom_widgets/image_container.dart';
import '../../../custom_widgets/text_feild/input_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> ResetPasswordViewModel(),
      child: Consumer<ResetPasswordViewModel>(
        builder: (context, model, child)=> Scaffold(
          backgroundColor: backgroundColor,

          appBar: AppBar(
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
            padding: EdgeInsets.fromLTRB(18.sp, 226.sp, 18.sp, 20.sp),
            child: Center(
              child: Column(
                children: [

                  Text("Reset Password", style: poppinTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(height: 4.h,),

                RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "We will send you an ",
                      style: poppinTextStyle.copyWith(
                        color: Colors.black.withOpacity(0.5),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                        text: "OTP ",
                        style: poppinTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),

                        ),
                    TextSpan(
                        text: "on this\nemail or mobile number",
                        style: poppinTextStyle.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                    ),
                      ]
                    )),

                  SizedBox(height: 24.h,),


                  InputTextField(
                    hintText: "Email or Mobile Number",
                    onChanged: (val){},

                  ),





                  SizedBox(height: 38.h,),

                  RoundedButton(text: "Reset Password", press: (){}),

                  SizedBox(height: 9.h,),
                  Text("Back to Login", style: poppinTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
