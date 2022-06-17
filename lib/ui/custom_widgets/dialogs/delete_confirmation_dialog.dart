// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/icons_path.dart';
import '../../../core/constants/text_styles.dart';
import '../button/rounded_button.dart';
import '../image_container.dart';


class DeleteConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 200.h,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ImageContainer(
            //   width: 30.w,
            //   height: 30.h,
            //   assets: IconPath.warningIcon,
            //   radius: 0,
            //   fit: BoxFit.contain,
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text("Are you sure you want to delete this record?",
                style: poppinTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),),
            ),

            SizedBox(height: 20.h,),

            Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    text: "No",
                    textSize: 15,
                    press: () {
                      Navigator.pop(context,false);
                    },
                  ),),

                SizedBox(width: 20.w,),

                Expanded(
                  child: RoundedButton(
                    textSize: 15,
                    text: "Yes",
                    press: (){
                      Navigator.pop(context,true);

                    },
                  ),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
