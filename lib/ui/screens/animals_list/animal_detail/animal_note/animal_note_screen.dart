// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/models/animal_note.dart';
import '../../../../../core/services/time_handler_services.dart';
import '../../../../../main.dart';
import '../../../../custom_widgets/custom_container.dart';
import '../../../../custom_widgets/dialogs/animal_note_dialog.dart';
import '../../../../custom_widgets/dialogs/delete_confirmation_dialog.dart';
import '../../../../custom_widgets/image_container.dart';
import '../../../../custom_widgets/text_view/text_views.dart';
import 'animal_note_view_model.dart';

class AnimalNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalNoteViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(7),
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
                          int itemCount = model.animalNoteRecord.length;
                          int reversedIndex = itemCount - 1 - index;

                          return CustomContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              textView18(
                                  text:
                                      "${model.animalNoteRecord[index].noteTitle}"
                                          .toUpperCase(),
                                  textColor: primaryColor),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Date: ${offerTimeHandler(model.animalNoteRecord[index].noteDate!)}",
                                    style: poppinTextStyle.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      AnimalNote? note =
                                          await Get.dialog(AnimalNoteDialog(
                                        animalNote:
                                            model.animalNoteRecord[index],
                                      ));

                                      if (note != null) {
                                        model.editAnimalNote(index, note);
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

                                      bool? isDelete =
                                          await Get.dialog(DeleteConfirmationDialog());

                                      if (isDelete != null) {
                                        if (isDelete) {
                                          model.deleteAnimalNote(index);
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
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 1.0.sp),
                                      child: Text(
                                        "Description:  ${model.animalNoteRecord[index].noteDescription}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ));
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: model.animalNoteRecord.length)),

                ///Todo: Expension Tile
                /*    Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          title: Text("${model.animalNoteRecord[index].noteTitle}".toUpperCase(),
                              style: poppinTextStyle),

                          children: [
                            Row(
                              children: [
                                Text("      Date: ${offerTimeHandler(model.animalNoteRecord[index].noteDate!)}",
                                  style: poppinTextStyle.copyWith(
                                    fontSize: 13.sp,
                                  ),),

                                Spacer(),

                                InkWell(onTap: () async{
                                  AnimalNote? note = await Get.dialog(AnimalNoteDialog(animalNote: model.animalNoteRecord[index],));

                                  if(note != null){
                                    model.editAnimalNote(index, note);
                                  }
                                },
                                  child: ImageContainer(
                                    height: 20.h,
                                    width: 20.w,
                                    assets: IconPath.editIcon1,
                                    radius: 0.r,
                                  ),),

                                SizedBox(width: 10.w,),

                                InkWell(onTap: (){
                                  model.deleteAnimalNote(index);
                                },
                                  child: ImageContainer(
                                    height: 20.h,
                                    width: 20.w,
                                    assets: IconPath.deleteIcon,
                                    radius: 0.r,
                                  ),),

                              ],
                            ),



                            SizedBox(height: 5.h,),
                            Row(
                              children: [
                                Expanded(
                                  child : Padding(
                                    padding:  EdgeInsets.only(left: 1.0.sp),
                                    child: Text("      Description:  ${model.animalNoteRecord[index].noteDescription}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 13.sp,
                                      ),),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(height: 10.h,),
                          ],
                        ),
                        separatorBuilder:  (context, index) => SizedBox(height: 10.h,),
                        itemCount: model.animalNoteRecord.length)),*/
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // AnimalNote? animalNote  = await Get.dialog(AnimalNoteDialog());
            //
            // if(animalNote != null){
            //   model.addAnimalNote(animalNote);
            // }

            ///Todo: Add Single record with same date
            var index = 0;
            var already = AnimalNote();
            for (var i = 0; i < model.animalNoteRecord.length; i++) {
              if (model.animalNoteRecord[i] != null) {
                if (model.animalNoteRecord[i].noteDate != null) {
                  var milkDate = formatTimeStampOfHealth(
                      model.animalNoteRecord[i].noteDate!);
                  var currentDate = formatTimeStampOfHealth(Timestamp.now());
                  if (milkDate == currentDate) {
                    logger.e(
                        "Date : ${formatTimeStampOfHealth(model.animalNoteRecord[i].noteDate!)}");
                    already = model.animalNoteRecord[i];
                    index = i;
                    i = model.animalNoteRecord.length + 1;
                  }
                }
              }
            }

            ///Todo: if already available record of current date then just update the record.
            AnimalNote? milk = AnimalNote();
            if (already.noteDate != null) {
              milk = await Get.dialog(AnimalNoteDialog(
                animalNote: already,
              ));

              if (milk != null) {
                model.editAnimalNote(index, milk);
              }
            } else {
              milk = await Get.dialog(AnimalNoteDialog());

              if (milk != null) {
                model.addAnimalNote(milk);
              }
            }
            ///.......................................................................

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
