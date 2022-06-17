// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/models/animal.dart';
import '../../../../../core/models/animal_family.dart';
import '../../../../custom_widgets/custom_container.dart';
import '../../../../custom_widgets/dialogs/animal_family_dialog.dart';
import '../../../../custom_widgets/dialogs/delete_confirmation_dialog.dart';
import '../../../../custom_widgets/image_container.dart';
import '../../../../custom_widgets/text_view/text_views.dart';
import 'animal_family_view_model.dart';

class AnimalFamilyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalFamilyViewModel>(
      builder: (context, model, child) => Scaffold(
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//            itemBuilder: (context, index) => Container(
//              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
//              decoration: BoxDecoration(
//                color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//             border: Border.all(color: Colors.black.withOpacity(0.5),)
//              ),
//              child: Row(
//                children: [
//                  ClipRRect(
//                    borderRadius: BorderRadius.circular(12),
//                    child: model.animalFamily[index].animal!.file == null ?
//                    ImageContainer(
//                      width: 101.w,
//                      height: 100.h,
//                      url: model.animalFamily[index].animal!.animalImage,
//                      fit: BoxFit.fill,
//                    ) : Image(
//                      image: FileImage(
//                        model.animalFamily[index].animal!.file!,
//                      ),
//                      width: 101.w,
//                      height: 100.h,
//                    ),
//                  ),
//
//                  SizedBox(width: 8.w,),
//
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      Text("${model.animalFamily[index].animal!.animalTag}".toUpperCase(),style: poppinTextStyle.copyWith(
//                          fontSize: 18.sp,
//                          fontWeight: FontWeight.w500,
//                          color: Colors.black
//                      ),),
//
//                      SizedBox(height: 10.h,),
//                      Text("${model.animalFamily[index].animalRelationShip}".toUpperCase(),style: poppinTextStyle.copyWith(
//                          fontSize: 18.sp,
//                          fontWeight: FontWeight.w500,
//                          color: Colors.black
//                      ),),
//                    ],
//                  )
//                ],
//              ),
//            ),
          itemBuilder: (context, index) {
            // return Container(
            // padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //
            //   border: Border(
            //     bottom: BorderSide(color: Colors.black.withOpacity(0.5),
            //         width: 1.sp),
            //   ),
            // ),

            return CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(12),
                      child: model.animalFamily[index].animal!.file == null
                          ? ImageContainer(
                              width: 101.w,
                              height: 130.h,
                              url:
                                  model.animalFamily[index].animal?.animalImage,
                              fit: BoxFit.fill,
                              radius: 6.sp,
                            )
                          : Image(
                              image: FileImage(
                                model.animalFamily[index].animal!.file!,
                              ),
                              width: 101.w,
                              height: 130.h,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),

                  // Expanded(
                  //   child:
                  // )

                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Tag and note and status section..
                              ///

                              SizedBox(
                                height: 5.h,
                              ),

                              textView16(
                                text:
                                    "${model.animalFamily[index].animal!.animalTag}"
                                        .toUpperCase(),
                                textColor: textDark,
                                fontWeight: FontWeight.w600,
                              ),

                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  textView12(
                                    text: "Relation Ship : ",
                                    textColor: textDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textView12(
                                    text:
                                        "${model.animalFamily[index].animalRelationShip} ${model.animalFamily[index].animalChildNumber ?? ""}",
                                    textColor: textDark,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 2.h,
                              ),

                              textView10(
                                text: "Here will be note for this ....",
                                textColor: textDark,
                                fontWeight: FontWeight.w400,
                              ),

                              SizedBox(
                                height: 10.h,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  animalTag(
                                      iconPath: IconPath.lactationIcon,
                                      value: "2"),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  animalTag(
                                      iconPath: IconPath.ageIcon, value: "3"),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  animalTag(
                                      iconPath: IconPath.weightIcon,
                                      value: "100kg"),
                                ],
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  _chip(
                                      tag:
                                          "${model.animalFamily[index].animal!.animalSex}",
                                      backgroundColor: primaryColor),
                                  SizedBox(
                                    width: 5.w,
                                  ),

                                  _chip(
                                      tag: "Australain",
                                      backgroundColor: primaryColor),
//                            SizedBox(width: 5.w,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              bool? isDelete =
                                  await Get.dialog(DeleteConfirmationDialog());

                              if (isDelete != null) {
                                if (isDelete) {
                                  model.deleteAnimalFamily(index);
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: ImageContainer(
                                height: 20.h,
                                width: 20.w,
                                assets: IconPath.deleteIcon,
                                radius: 0.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Container(
            height: 10,
          ),
          itemCount: model.animalFamily.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // model.animals
            // widget.newAnimalList
            //     .removeWhere((element) => element.animalUid == widget.animalID);



            List<Animal> updatedAnimalList=model.removeCurrentAnimal(model.animalID, model.animals);

            AnimalFamily? family = await Get.dialog(AnimalFamilyDialog(
              animal: updatedAnimalList,
              newAnimalList: model.animals,
              animalFamily: model.animalFamily,
              animalID: model.animalID,
            ));
            if (family != null) {
              model.addFamily(family);
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

  Widget animalTag({required String iconPath, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageContainer(
          height: 22.h,
          width: 22.w,
          assets: iconPath,
          radius: 0.r,
          fit: BoxFit.contain,
        ),
        SizedBox(
          height: 3.h,
        ),
        // Text(
        //   value,
        //   style: poppinTextStyle.copyWith(
        //     fontSize: 12.sp,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.black,
        //   ),

        textView12(
          text: value,
          textColor: textDark,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _chip({
    required String tag,
    required Color backgroundColor,
  }) {
    return Container(
//      height: 25.sp,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor.withOpacity(0.3),
//        border: Border.all(color: primaryColor)
      ),
      child: Center(
        child: textView14(
            text: tag, textColor: textDark, fontWeight: FontWeight.w400),
      ),
    );
  }
}
