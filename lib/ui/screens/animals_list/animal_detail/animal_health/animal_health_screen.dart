// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/models/animal_health.dart';
import '../../../../../core/services/time_handler_services.dart';
import '../../../../custom_widgets/custom_container.dart';
import '../../../../custom_widgets/dialogs/animal_health_dialog.dart';
import '../../../../custom_widgets/dialogs/delete_confirmation_dialog.dart';
import '../../../../custom_widgets/image_container.dart';
import '../../../../custom_widgets/text_view/text_views.dart';
import 'animal_health_view_model.dart';

class AnimalHealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalHealthViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),

                ///Todo: List View
                Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  textView18(
                                      text:
                                      "${model.animalHealthRecord[index].healthTitle}"
                                          .toUpperCase(),
                                      textColor: primaryColor),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date: ${offerTimeHandler(model.animalHealthRecord[index].healthDate!)}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          AnimalHealth? health =
                                          await Get.dialog(AnimalHealthDialog(
                                            health:
                                            model.animalHealthRecord[index],
                                          ));

                                          if (health != null) {
                                            model.editAnimalHealth(index, health);
                                          }
                                        },
                                        child: ImageContainer(
                                          height: 20.h,
                                          width: 20.w,
                                          assets: IconPath.editIcon1,
                                          radius: 0.r,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          bool? isDelete = await Get.dialog(
                                              DeleteConfirmationDialog());
                                          if (isDelete != null) {
                                            if (isDelete) {
                                              model.deleteAnimalHealth(index);
                                            }
                                          }

                                        },
                                        child: ImageContainer(
                                          height: 20.h,
                                          width: 20.w,
                                          assets: IconPath.deleteIcon,
                                          radius: 0.r,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Cost Rs: ${model.animalHealthRecord[index].healthCost}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Description:  ${model.animalHealthRecord[index].healthDescription}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemCount: model.animalHealthRecord.length)),

                ///Todo: ExpansionTile
              /*  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              *//*title: Text(
                                  "${model.animalHealthRecord[index].healthTitle}"
                                      .toUpperCase(),
                                  style: poppinTextStyle),*//*
                              title: textView24(
                                  text:
                                      "${model.animalHealthRecord[index].healthTitle}"
                                          .toUpperCase(),
                                  textColor: textDark,
                                  fontWeight: FontWeight.w700),
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "      Date: ${offerTimeHandler(model.animalHealthRecord[index].healthDate!)}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        AnimalHealth? health =
                                            await Get.dialog(AnimalHealthDialog(
                                          health:
                                              model.animalHealthRecord[index],
                                        ));

                                        if (health != null) {
                                          model.editAnimalHealth(index, health);
                                        }
                                      },
                                      child: ImageContainer(
                                        height: 20.h,
                                        width: 20.w,
                                        assets: IconPath.editIcon1,
                                        radius: 0.r,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        bool? isDelete = await Get.dialog(
                                            DeleteConfirmationDialog());
                                        if (isDelete != null) {
                                          if (isDelete) {
                                            model.deleteAnimalHealth(index);
                                          }
                                        }

                                      },
                                      child: ImageContainer(
                                        height: 20.h,
                                        width: 20.w,
                                        assets: IconPath.deleteIcon,
                                        radius: 0.r,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "      Cost Rs: ${model.animalHealthRecord[index].healthCost}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "      Description:  ${model.animalHealthRecord[index].healthDescription}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: model.animalHealthRecord.length)),*/
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            AnimalHealth? animalHealth = await Get.dialog(AnimalHealthDialog());

            if (animalHealth != null) {
              model.addAnimalHealth(animalHealth);
            }
          },
          backgroundColor: primaryColor,
          child: Icon(
            Icons.add,
            size: 25.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
