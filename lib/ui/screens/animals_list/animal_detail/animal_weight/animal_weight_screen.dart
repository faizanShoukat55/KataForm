// ignore_for_file: use_key_in_widget_constructors, must_be_immutable



import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/models/animal.dart';
import '../../../../../core/models/animal_weight.dart';
import '../../../../../core/services/time_handler_services.dart';
import '../../../../../main.dart';
import '../../../../custom_widgets/custom_container.dart';
import '../../../../custom_widgets/dialogs/animal_weight_dialog.dart';
import '../../../../custom_widgets/dialogs/delete_confirmation_dialog.dart';
import '../../../../custom_widgets/image_container.dart';
import 'animal_weight_view_model.dart';

class AnimalWeightScreen extends StatelessWidget {
  // final Animal animal;
  //
  // const AnimalWeightScreen({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) => AnimalWeightViewModel(animal),
    //   child: Consumer<AnimalWeightViewModel>(
    //     builder: (context, model, child) =>
    //   ),
    // );

    return Consumer<AnimalWeightViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
//                Align(
//                    alignment: Alignment.centerRight,
//                    child: RoundedButton(text: "Add Animal Health", press: (){}, textSize: 15, width: 160)),

                Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int itemCount = model.animalNoteRecord.length;
                          int reversedIndex = itemCount - 1 - index;

                          // return Container(
                          //   padding:const EdgeInsets.symmetric(
                          //       horizontal: 8, vertical: 10),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: darkGrayColor),
                          //     color: lightSilverColor.withOpacity(0.4),
                          //     borderRadius: BorderRadius.circular(25.r),
                          //   ),

                          return CustomContainer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "${model.animalNoteRecord[reversedIndex].totalKg}"
                                                .toUpperCase() +
                                                " KG",
                                            style: poppinTextStyle),
                                        SizedBox(
                                          width: 5.h,
                                        ),
                                        model.animalNoteRecord[reversedIndex]
                                            .isHighest!
                                            ? Icon(
                                          Icons.check_circle,
                                          size: 25.sp,
                                          color: primaryColor,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        "Difference: ${model.animalNoteRecord[reversedIndex].difference}",
                                        style: poppinTextStyle.copyWith(
                                          fontSize: 15.sp,
                                        )),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "Date ${offerTimeHandler(model.animalNoteRecord[reversedIndex].weightDate!)}",
                                      style: poppinTextStyle.copyWith(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {
                                    AnimalWeight? note =
                                    await Get.dialog(AnimalWeightDialog(
                                      animalWeight: model
                                          .animalNoteRecord[reversedIndex],
                                    ));

                                    if (note != null) {
                                      model.editAnimalNote(
                                          reversedIndex, note);
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
                                        model.deleteAnimalWeight(reversedIndex);
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
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemCount: model.animalNoteRecord.length)),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            logger.e("on pressed");
            AnimalWeight? animalNote = await Get.dialog(AnimalWeightDialog());

            if (animalNote != null) {
              model.addAnimalWeight(animalNote);
            }
          },
          backgroundColor: primaryColor,
          child: Icon(
            Icons.add,
            size: 25.sp,
            color: Colors.white,
          ),
        ),
      ));
  }
}
