// ignore_for_file: use_key_in_widget_constructors

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/icons_path.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/animal.dart';
import '../../../main.dart';
import '../../custom_widgets/dialogs/confirm_animal_entry_dialog.dart';
import '../../custom_widgets/image_container.dart';
import '../../custom_widgets/text_view/text_views.dart';
import 'add_animal/add_animal_screen.dart';
import 'animal_detail/animal_detail_screen.dart';
import 'animal_list_view_model.dart';
import 'multi_animal_entries/multi_animal_entries_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text("Channab", style: appBarTextStyle),
            backgroundColor: backgroundColor,
            elevation: 0.0,
            actions: [
              IconButton(
                  onPressed: () {
                    model.logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 20.sp,
                    color: primaryColor,
                  )),
            ],
          ),
          body: model.state == ViewState.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.sp, horizontal: 12.sp),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          logger.e("before size : ${model.animalList.length}");
                          Animal? animal = await Get.to(() =>
                              AnimalDetailScreen(
                                  animal: model.animalList[index],
                                  animals: model.animalList));

                          logger.e("after size : ${model.animalList.length}");

                          if (animal != null) {
                            model.update(animal, index);
                          }
                        },

                        // child : Container(
                        //   padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border(
                        //       bottom: BorderSide(color: Colors.black.withOpacity(0.5),
                        //       width: 1.sp),
                        //     ),
                        //   ),

                        ///New Tile Style
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.sp, horizontal: 12.sp),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.sp))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(12),
                                  child: model.animalList[index].file == null
                                      ? ImageContainer(
                                          width: 101.w,
                                          height: 110.h,
                                          url: model
                                              .animalList[index].animalImage,
                                          fit: BoxFit.fill,
                                          radius: 6.sp,
                                        )
                                      : Image(
                                          image: FileImage(
                                            model.animalList[index].file!,
                                          ),
                                          width: 101.w,
                                          height: 110.h,
                                        ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5.h),

                                        /// Tag and note and status section..
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 220.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // Text("${model.animalList[index].animalTag}".toUpperCase(),style: poppinTextStyle.copyWith(
                                                  //     fontSize: 18.sp,
                                                  //     fontWeight: FontWeight.w500,
                                                  //     color: Colors.black
                                                  //   ),),

                                                  textView16(
                                                      text:
                                                          "${model.animalList[index].animalTag}"
                                                              .toUpperCase(),
                                                      textColor: textDark,
                                                      fontWeight:
                                                          FontWeight.w700),

                                                  textView12(
                                                    maxLines: 2,
                                                      text: model
                                                                  .animalList[
                                                                      index]
                                                                  .animalNoteObject !=
                                                              null
                                                          ? model
                                                                  .animalList[
                                                                      index]
                                                                  .animalNoteObject!
                                                                  .noteDescription ??
                                                              ""
                                                          : "",
                                                      textColor: textDark,
                                                      fontWeight:
                                                          FontWeight.w400),

                                                  // Text("Here will be note for this ....",style: poppinTextStyle.copyWith(
                                                  //     fontSize: 12.sp,
                                                  //     fontWeight: FontWeight.w400,
                                                  //     color: Colors.black
                                                  // ),),
                                                ],
                                              ),
                                            ),
                                            // ImageContainer(
                                            //   height: 16.h,
                                            //   width: 16.w,
                                            //   assets: IconPath.activeIcon,
                                            //   radius: 0.r,
                                            //   fit: BoxFit.contain,
                                            // ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 7.h,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            animalTag(
                                                iconPath:
                                                    IconPath.lactationIcon,
                                                value:
                                                    "${model.animalList[index].animalLactation}"),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            animalTag(
                                                iconPath: IconPath.ageIcon,
                                                value:
                                                    " Y ${AgeCalculator.age(model.animalList[index].animalDOB == null ? DateTime.now() : DateTime.parse(model.animalList[index].animalDOB!.isEmpty ? "${DateTime.now()}" : "${model.animalList[index].animalDOB}")).years},"
                                                    " M ${AgeCalculator.age(model.animalList[index].animalDOB == null ? DateTime.now() : DateTime.parse(model.animalList[index].animalDOB!.isEmpty ? "${DateTime.now()}" : "${model.animalList[index].animalDOB}")).months}"),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            animalTag(
                                                iconPath: IconPath.weightIcon,
                                                value:
                                                    "${model.animalList[index].animalWeight}KG"),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            _chip(
                                                tag:
                                                    "${model.animalList[index].animalSex}",
                                                backgroundColor: primaryColor),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            _chip(
                                                tag:
                                                    "${model.animalList[index].animalGenetics}",
                                                backgroundColor: primaryColor),
                                            // const Spacer(),

                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Visibility(
                                              visible: model.animalList[index].pregnantStatus != null
                                                  ? model.animalList[index].pregnantStatus!
                                                  : false,
                                              child: _chip(
                                                  tag:
                                                  model.animalList[index].pregnantStatus != null ? model.animalList[index].pregnantStatus==true ? "Pregnant":"" : "",
                                                  backgroundColor: primaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    ///Todo: top status Icon
                                    ImageContainer(
                                      height: 16.h,
                                      width: 16.w,
                                      assets: IconPath.activeIcon,
                                      radius: 0.r,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                  itemCount: model.animalList.length),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () async {
              bool? isDone = await Get.dialog(ConfirmAnimalEntryDialog());

              if (isDone != null) {
                if (isDone) {
                  Animal? animal = await Get.dialog(AddAnimalScreen());
                  print("AnimaL foREM => ${animal}");
                  if (animal != null) {
                    model.addAnimal(animal);
                  }
                } else if (!isDone) {
                  List<Animal>? animals =
                      await Get.dialog(MultiEntriesAnimalScreen());

                  if (animals != null) {
                    model.addMultiAnimals(animals);
                  }
                }
              }
            },
            child: Icon(
              Icons.add,
              size: 25.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
        // child: Text(tag,
        //   style: poppinTextStyle.copyWith(
        //     fontWeight: FontWeight.w400,
        //     fontSize: 12.sp,
        //     color: primaryColor,
        //
        //   ),),

        child: textView14(
            text: tag, textColor: textDark, fontWeight: FontWeight.w400),
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

        // Text(value,
        // style: poppinTextStyle.copyWith(
        //   fontSize: 12.sp,
        //   fontWeight: FontWeight.w500,
        //   color: Colors.black,
        // ),),

        textView12(
          text: value,
          textColor: textDark,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
