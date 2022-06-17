// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/text_styles.dart';
import '../button/rounded_button.dart';


class ConfirmAnimalEntryDialog extends StatelessWidget {
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

            Text("Do you want to add single animal or multiple animals.",
            style: poppinTextStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),),

            SizedBox(height: 20.h,),

            Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    text: "Single Entry",
                    textSize: 15,
                    press: () {
                      Navigator.pop(context,true);
//                      Get.to(()=> AddAnimalScreen());
//                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddAnimalScreen()));//                        Get.to(()=>UserChatScreen(name: offer.traineeName!));
//                        rootViewModel.updateIndex(0);
                    },
                  ),),

                SizedBox(width: 10.w,),

                Expanded(
                  child: RoundedButton(
                    textSize: 15,
                    text: "Multiple Entries",
                    press: (){
                      Navigator.pop(context,false);

//                      Get.to(()=> MultiEntriesAnimalScreen());
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
