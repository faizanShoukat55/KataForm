// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/animal.dart';
import '../../../core/models/animal_family.dart';
import '../../../core/others/time_handler.dart';
import '../../../core/services/auth_services.dart';
import '../../../locator.dart';
import '../../../main.dart';
import '../button/rounded_button.dart';
import '../image_container.dart';
import '../search_bar.dart';

class AnimalFamilyDialog extends StatefulWidget {
  List<Animal> animal = [];
  List<Animal> newAnimalList = [];
  List<AnimalFamily> animalFamily = [];
  String animalID;

  AnimalFamilyDialog(
      {required this.animal,
      required this.newAnimalList,
      required this.animalFamily,
      required this.animalID});

  @override
  State<AnimalFamilyDialog> createState() => _AnimalFamilyDialogState();
}

class _AnimalFamilyDialogState extends State<AnimalFamilyDialog> {
  TextEditingController controller = TextEditingController();
  List<Animal> listOfAnimal = [];
  List<Animal> listOfFilterAnimal = [];
  List<Animal> listOfUpdatedAnimal = [];
  Animal animal = Animal();
  int _groupValue = -1;

  /// Unmodifiable filter List
  UnmodifiableListView<Animal> get animals => listOfFilterAnimal.isEmpty
      ? UnmodifiableListView(widget.animal)
      : UnmodifiableListView(listOfFilterAnimal);

  // List<Animal> get animals =>
  //     listOfFilterAnimal.isEmpty ? widget.animal : listOfFilterAnimal;

  final authService = locator<AuthService>();

  searchByName(String keyword) {
    listOfFilterAnimal.clear();
    listOfFilterAnimal = widget.animal
        .where(
            (e) => (e.animalTag!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();
    setState(() {});
  }

  bool isLoading = false;

  bool searchParentRelationShip(String relationShip) {
    setState(() {
      isLoading = true;
    });

    final index = widget.animalFamily.indexWhere(
        (element) => element.animalRelationShip!.compareTo(relationShip) == 0);

    setState(() {
      isLoading = false;
    });
    if (index != -1) {
      return true;
    } else {
      return false;
    }
  }

  int findChildNumber() {
    final index = widget.animalFamily.indexWhere((element) =>
        element.animalRelationShip!.toLowerCase().compareTo("child") == 0);

    print("Child Index $index");
    if (index == -1) {
      return 1;
    } else {
      return index + 1;
    }
  }

  bool checkAnimalAlreadyExist(String id) {
    setState(() {
      isLoading = true;
    });

    int index = widget.animalFamily
        .indexWhere((element) => element.animal!.animalUid!.compareTo(id) == 0);
    setState(() {
      isLoading = false;
    });
    if (index == -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    //widget.newAnimalList = widget.animal;

    // logger.e("clicked animal Id : ${widget.animalID}");
    // for (var i = 0; i < widget.newAnimalList.length; i++) {
    //   logger.e("animal Id : ${widget.newAnimalList[i].animalUid}");
    //   if (widget.newAnimalList[i].animalUid==widget.animalID) {
    //     setState(() {
    //       widget.newAnimalList.removeAt(i);
    //     });
    //   }
    // }

    // logger.e("clicked animal Id : ${widget.animalID}");
    // for (var i = 0; i < widget.animal.length; i++) {
    //   logger.e("animal Id : ${widget.animal[i].animalUid}");
    //   if (widget.animal[i].animalUid==widget.animalID) {
    //     setState(() {
    //       widget.animal.removeAt(i);
    //     });
    //   }
    // }

    // logger.e("before size : ${widget.newAnimalList.length}");
    // ///Todo: Remove the same animal as it can not be
    // setState(() {
    //   // widget.newAnimalList
    //   //     .removeWhere((element) => element.animalUid == widget.animalID);
    //
    // });
    //
    // logger.e("after size : ${widget.newAnimalList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          height: 750.h,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xffE5E5E5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Family",
                  style: poppinTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Container(
                  height: 500.h,
                  child: Column(
                    children: [
                      SearchBar(
                        onPress: (val) {
                          searchByName(val);
                        },
                        hintText: "Search Animal",
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              setState(() {
                                animal = animals[index];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: (animal.animalTag != null &&
                                        animal.animalTag!.compareTo(
                                                animals[index].animalTag!) ==
                                            0)
                                    ? primaryColor.withOpacity(0.3)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: animals[index].file == null
                                        ? ImageContainer(
                                            width: 53.w,
                                            height: 36.h,
                                            url: animals[index].animalImage,
                                            fit: BoxFit.fill,
                                          )
                                        : Image(
                                            image: FileImage(
                                              animals[index].file!,
                                            ),
                                            width: 53.w,
                                            height: 36.h,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    "${animals[index].animalTag}".toUpperCase(),
                                    style: poppinTextStyle.copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5.h,
                          ),
                          itemCount: animals.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///Todo Father
                    Visibility(
                      visible: animal.animalSex == "Male" ? true : false,
                      child: _myRadioButton(
                        title: "Father",
                        value: 1,
                        onChanged: (newValue) async {
                          bool isFind =
                              await searchParentRelationShip("Father");

                          if (isFind) {
                            Get.snackbar("Already Father Added",
                                "Kindly correct relationship already father relationship is added",
                                backgroundColor: primaryColor,
                                colorText: Colors.white);
                          } else {
                            setState(() => _groupValue = newValue);
                          }
                        },
                      ),
                    ),

                    ///Todo Mather
                    Visibility(
                      visible: animal.animalSex == "Male" ? false : true,
                      child: _myRadioButton(
                        title: "Mother",
                        value: 2,
                        onChanged: (newValue) async {
                          bool isFind =
                              await searchParentRelationShip("Mother");

                          if (isFind) {
                            Get.snackbar("Already Father Mother",
                                "Kindly correct relationship already mother relationship is added",
                                backgroundColor: primaryColor,
                                colorText: Colors.white);
                          } else {
                            setState(() => _groupValue = newValue);
                          }
                        },
                      ),
                    ),

                    ///Todo Child
                    _myRadioButton(
                      title: "Child",
                      value: 3,
                      onChanged: (newValue) =>
                          setState(() => _groupValue = newValue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 19.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        text: "Cancel",
                        textSize: 15,
                        textColor: Colors.white,
                        color: lightSilverColor,
                        press: () {
                          Navigator.pop(context, null);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: RoundedButton(
                        textSize: 15,
                        text: "Add Family",
                        press: () async {
                          if (animal.animalTag == null) {
                            Get.snackbar("Select Animal",
                                "Kindly select animal before adding relationship.",
                                backgroundColor: primaryColor,
                                colorText: Colors.white);
                          } else {
                            if (_groupValue == -1) {
                              Get.snackbar("Select relation",
                                  "Kindly select relationship with animal",
                                  backgroundColor: primaryColor,
                                  colorText: Colors.white);
                            } else {
                              bool value = await checkAnimalAlreadyExist(
                                  animal.animalUid!);

                              if (value) {
                                int childNumber = await findChildNumber();
                                AnimalFamily animalFamily = AnimalFamily(
                                    animal: animal,
                                    animalRelationShip: _groupValue == 1
                                        ? "Father"
                                        : _groupValue == 2
                                            ? "Mother"
                                            : "child",
                                    farmOwnerID: authService.appUser!.uid!,
                                    animalChildNumber: _groupValue > 2
                                        ? childNumber.toString()
                                        : "",
                                    animalID: widget.animalID,
                                    familyID: uid() +
                                        "${DateTime.now().microsecondsSinceEpoch}");

                                Navigator.pop(context, animalFamily);
                              } else {
                                Get.snackbar("Already Family Member",
                                    "This is already your family member you can not add it again",
                                    colorText: Colors.white,
                                    backgroundColor: primaryColor);
                              }
                            }
                          }

//                      Get.to(()=> MultiEntriesAnimalScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myRadioButton(
      {required String title, required int value, required onChanged}) {
    return Container(
      width: 110.w,
      child: RadioListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        activeColor: primaryColor,
        value: value,
        groupValue: _groupValue,
        onChanged: onChanged,
        title: Text(
          title,
          style: poppinTextStyle.copyWith(
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
