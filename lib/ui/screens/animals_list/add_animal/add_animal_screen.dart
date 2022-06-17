// ignore_for_file: use_key_in_widget_constructors

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/services/time_handler_services.dart';
import '../../../custom_widgets/button/rounded_button.dart';
import '../../../custom_widgets/drop_down/custom_drop_down.dart';
import '../../../custom_widgets/image_container.dart';
import '../../../custom_widgets/text_feild/input_text_field.dart';
import '../../../custom_widgets/text_view/text_views.dart';
import 'add_animal_view_model.dart';

class AddAnimalScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddAnimalViewModel(),
      child: Consumer<AddAnimalViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            // title: Text("Add Animal",
            //     style: appBarTextStyle.copyWith(color: Colors.white)),
            title: textView18(
                text: "Add Animal",
                textColor: textLight,
                fontWeight: FontWeight.w700),
            backgroundColor: primaryColor,
            elevation: 0.0,
            actions: [
//          ImageContainer(
//            width: 26.sp,
//            height: 15.sp,
//            assets: IconPath.menuIcon,
//            radius: 0,
//            fit: BoxFit.contain,
//          ),

              SizedBox(
                width: 15.w,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      model.pickImageFromGallery();
                    },
                    child: model.profileImage == null
                        ? DottedBorder(
                            radius: const Radius.circular(8),
                            color: primaryColor,
                            dashPattern: [8, 4],
                            strokeWidth: 2,
                            child: Container(
                              height: 100.h,
                              width: 390.w,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageContainer(
                                      width: 55.w,
                                      height: 49.h,
                                      assets: IconPath.uploadImageIcon,
                                      radius: 0.r,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      "Upload Image",
                                      style: poppinTextStyle.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Image(
                            height: 100.h,
                            width: 390.w,
                            image: FileImage(model.profileImage!),
                            fit: BoxFit.fill,
                          ),
                  ),

                  SizedBox(
                    height: 16.h,
                  ),

                  /// Animal Tag
                  _heading("Animal Tag"),

                  SizedBox(
                    height: 6.h,
                  ),

                  InputTextField(
                    hintText: "Animal Tag",
                    maxLength: 50,
                    validation: (String? val) {
                      if (val!.isEmpty || val.length < 1) {
                        return "Please Enter Animal Tag";
                      }
                      if (val.length > 70) {
                        return "Animal tag  should not be greater than 70 character";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      model.animal.animalTag = val;
                      model.updateState();
                    },
                    controller: model.animalTagController,
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  /// Date of Birth
                  _heading("Date of Birth"),

                  SizedBox(
                    height: 6.h,
                  ),

                  InputTextField(
                    hintText: "Date of Birth",
                    isReadOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime.now());

                      if (selectedDate != null) {
//                        model.animal.animalDOB = formatDateTimeOfHealth(selectedDate);
                        model.animal.animalDOB = selectedDate.toString();
                        model.dateOfBirthTextEditController =
                            TextEditingController(
                                text: formatDateTimeOfHealth(selectedDate));
                        model.updateState();
                      }
                    },
                    validation: (String? val) {
                      if (val!.isEmpty || val.length < 1) {
                        return "Please Enter  Date";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {},
                    controller: model.dateOfBirthTextEditController,
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  /// Category
                  _heading("Animal Category"),

                  SizedBox(
                    height: 6.h,
                  ),

                  DropDownMenu(
//                            selectedValue: ,
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "Please Select Animal Category";
                      } else {
                        return null;
                      }
                    },
                    searchText: "Category",
                    searchList: model.category,
                    onSelected: (String? val) {
                      model.animal.animalCategory = val;
                      model.updateState();
                    },
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  /// Category
                  _heading("Animal Type"),

                  SizedBox(
                    height: 6.h,
                  ),

                  DropDownMenu(
//                            selectedValue: ,
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "Please Select Animal type";
                      } else {
                        return null;
                      }
                    },
                    searchText: "Type",
                    searchList: model.animalTypes,
                    onSelected: (String? val) {
                      if (val == "Male") {
                        model.pregnantOption = false;
                      } else {
                        model.pregnantOption = true;
                      }
                      model.animal.animalSex = val;
                      model.updateState();
                    },
                  ),

                  SizedBox(
                    height: 6.h,
                  ),

                  /// Pregnant status
                  Visibility(
                    visible: model.pregnantOption,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _heading("Pregnant Status"),
                        SizedBox(
                          height: 6.h,
                        ),
                        DropDownMenu(
//                            selectedValue: ,
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return "Please Select Pregnant Status";
                            } else {
                              return null;
                            }
                          },
                          searchText: "Status",
                          searchList: model.pregnantStatus,
                          onSelected: (String? val) {

                            model.animal.pregnantStatus = val=="No" ? false : true;
                            model.updateState();
                          },
                        ),
                      ],
                    ),
                  ),

                  model.advanceOption
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            _heading("Animal Weight"),
                            SizedBox(
                              height: 6.h,
                            ),
                            InputTextField(
                              hintText: "Animal Weight",
//                        validation: (String? val){
//                          if(val!.isEmpty || val.length < 1){
//                            return "Please Enter Animal Weight";
//                          }if(val.length > 70){
//                            return "Animal Weight  should not be greater than 70 character";
//                          }
//                          else{
//                            return null;
//                          }
//                        },
                              inputType: TextInputType.number,
                              onChanged: (val) {
                                model.animal.animalWeight = val;
                                model.updateState();
                              },
                              controller: model.animalWightController,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            _heading("Animal Genetic"),
                            SizedBox(
                              height: 6.h,
                            ),
                            InputTextField(
                              hintText: "Animal Genetic",
//                        validation: (String? val){
//                          if(val!.isEmpty || val.length < 1){
//                            return "Please Enter Animal Weight";
//                          }if(val.length > 70){
//                            return "Animal Weight  should not be greater than 70 character";
//                          }
//                          else{
//                            return null;
//                          }
//                        },
                              onChanged: (val) {
                                model.animal.animalGenetics = val;
                                model.updateState();
                              },
                              controller: model.animalGenticsController,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            _heading("Animal Lactation"),
                            SizedBox(
                              height: 6.h,
                            ),
                            InputTextField(
                              hintText: "Animal Lactation",
//                        validation: (String? val){
//                          if(val!.isEmpty || val.length < 1){
//                            return "Please Enter Animal Weight";
//                          }if(val.length > 70){
//                            return "Animal Weight  should not be greater than 70 character";
//                          }
//                          else{
//                            return null;
//                          }
//                        },
                              onChanged: (val) {
                                model.animal.animalLactation = val;
                                model.updateState();
                              },
                              controller: model.animalLactationController,
                            ),
                          ],
                        )
                      : Container(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          model.advanceOption = !model.advanceOption;
                          model.updateState();
                        },
                        child: textView14(
                          text: (model.advanceOption ? "Roll Up" : "See More"),
                          textColor: textDark,
                          fontWeight: FontWeight.w600,
                        ),
                        // child: Text("${model.advanceOption ? "Roll Up" : "See More"}",
                        //   style: poppinTextStyle.copyWith(
                        //     color: primaryColor,
                        //     fontSize: 15.sp,
                        //   ),),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  Center(
                    child: RoundedButton(
                      width: 250.w,
                      textSize: 20,
                      text: "Save Information",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          // visible: model.animal.animalSex.isNotEmpty ? model.animal.animalSex=="Male" ? false :true :false,
                          if (model.animal.animalSex != null) {
                            if (model.animal.animalSex != "Male") {
                              // model.animal.pregnantStatus = "Pregnant";
                            } else {
                              model.animal.pregnantStatus = false;
                            }
                          } else {
                            model.animal.pregnantStatus = false;
                          }
                          model.registerAnimalToServer();
                          Navigator.pop(context, model.animal);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _heading(String tag) {
    // return Text(tag, style: poppinTextStyle.copyWith(
    //     fontSize: 15.sp,
    //     fontWeight: FontWeight.w600
    // ));
    return textView16(
      text: tag,
      textColor: textDark,
      fontWeight: FontWeight.w600,
    );
  }
}
