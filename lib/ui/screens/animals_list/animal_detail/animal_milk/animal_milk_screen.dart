// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/models/animal_milk.dart';
import '../../../../../core/services/time_handler_services.dart';
import '../../../../../main.dart';
import '../../../../custom_widgets/button/rounded_button.dart';
import '../../../../custom_widgets/dialogs/animal_milk_dialog.dart';
import '../../../../custom_widgets/dialogs/confirmation_dialog.dart';
import 'animal_milk_view_model.dart';

class AnimalMilkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size??0.0;
    return Consumer<AnimalMilkViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 20.h,
            ),

            /// center add button
            Padding(
              padding: EdgeInsets.only(left: 90.w, right: 90.w),
              child: RoundedButton(
                height: 35,
                text: "Add",
                textSize: 15,
                textColor: Colors.white,
                color: primaryColor,
                press: () async {

                  ///Todo: Add Multiple records with same date
/*                  AnimalMilk? milk = await Get.dialog(AnimalMilkDialog());
                  if (milk != null) {
                    model.addMilkRecord(milk);
                  }*/


                ///Todo: Add Single record with same date
                  logger.e("Current TimeStamp :${formatTimeStampOfHealth(Timestamp.now())}");
                  var index = 0;
                  var already = AnimalMilk();
                  for (var i = 0; i < model.milkRecord.length; i++) {
                    if (model.milkRecord[i] != null) {
                      if (model.milkRecord[i].milkDate != null) {
                        var milkDate=formatTimeStampOfHealth(model.milkRecord[i].milkDate!);
                        var currentDate=formatTimeStampOfHealth(Timestamp.now());
                        if (milkDate==currentDate) {
                          logger.e("Date : ${formatTimeStampOfHealth(model.milkRecord[i].milkDate!)}");
                          already = model.milkRecord[i];
                          index = i;
                          i = model.milkRecord.length + 1;
                        }

                      }
                    }
                  }

                  // var already = model.milkRecord
                  //     .where((item) =>
                  //         formatTimeStampOfHealth(item.milkDate!) ==
                  //         formatTimeStampOfHealth(Timestamp.now()))
                  //     .first;

                  ///Todo: if already available record of current date then just update the record.
                  AnimalMilk? milk = AnimalMilk();
                  if (already.milkDate != null) {
                    milk = await Get.dialog(AnimalMilkDialog(
                      animalMilk: already,
                    ));

                    if (milk != null) {
                      model.editAnimalMilk(index, milk);
                    }
                  } else {
                    milk = await Get.dialog(AnimalMilkDialog());

                    if (milk != null) {
                      model.addMilkRecord(milk);
                    }
                  }
                },
              ),
            ),

            /// Side Circular add button
            /*  InkWell(
                onTap: () async {
                  AnimalMilk? milk = await Get.dialog(AnimalMilkDialog());

                  if(milk != null){
                    model.addMilkRecord(milk);
                  }

                },
                child: Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ),
              ),*/

            SizedBox(
              height: 10.h,
            ),

            /// Heading Row
            Padding(
              padding: const EdgeInsets.only(right: 1.0, left: 1.0),
              // padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: model.milkRecord.isEmpty ? false : true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60.w,
                      child: Center(
                        child: Text(
                          "Date",
                          style: poppinTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Center(
                        child: Text(
                          "1st Time",
                          style: poppinTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Center(
                        child: Text(
                          "2nd Time",
                          style: poppinTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Center(
                        child: Text(
                          "3rd Time",
                          style: poppinTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Center(
                        child: Text(
                          "Total",
                          style: poppinTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /*SizedBox(
                height: 320.h,
                child:
              ),*/

            /// Data ListView
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 1.0, left: 1.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        itemBuilder: (context, index) => InkWell(
                          onLongPress: () async {
                            bool? isDelete =
                            await Get.dialog(ConfirmationDialog());

                            if (isDelete != null) {
                              if (isDelete) {
                                model.deleteAnimalMilkRecord(index);
                              } else {
                                AnimalMilk? milk =
                                await Get.dialog(AnimalMilkDialog(
                                  animalMilk: model.milkRecord[index],
                                ));

                                if (milk != null) {
                                  model.editAnimalMilk(index, milk);
                                }
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: darkGrayColor.withOpacity(0.4)),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  child: Center(
                                    child: Text(
                                      formatTimeStampOfHealth(
                                          model.milkRecord[index].milkDate!),
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60.w,
                                  child: Center(
                                    child: Text(
                                      "${model.milkRecord[index].milkFirstTime}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60.w,
                                  child: Center(
                                    child: Text(
                                      "${model.milkRecord[index].milkSecondTime}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60.w,
                                  child: Center(
                                    child: Text(
                                      "${model.milkRecord[index].milkThirdTime}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40.w,
                                  height: 18.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffC4C4C4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${model.milkRecord[index].totalMilk}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.h,
                        ),
                        itemCount: model.milkRecord.length,
                        shrinkWrap: true,
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Visibility(
                            visible: model.milkRecord.isEmpty ? false : true,
                            child: Container(
                              height: 50.h,
                              color: lightSilverColor.withOpacity(0.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    child: Center(
                                      child: Text(
                                        "Total",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: Center(
                                      child: Text(
                                        "${model.totalFirstTimeMilk}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: Center(
                                      child: Text(
                                        "${model.totalSecondTimeMilk}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: Center(
                                      child: Text(
                                        "${model.totalThirdTimeMilk}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    margin: EdgeInsets.only(right: 10.sp),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffC4C4C4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${model.totalMilk}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            )

            /*    Container(height: size.height*0.8,),*/
          ],
        ),

        /*  floatingActionButton: FloatingActionButton(
          onPressed: () async{
            AnimalMilk? milk = await Get.dialog(AnimalMilkDialog());

            if(milk != null){
              model.addMilkRecord(milk);
            }


          },
          backgroundColor: primaryColor,
          child: Icon(Icons.add, size: 25.sp, color: Colors.white,),
        ),*/
      ),
    );
  }
}
