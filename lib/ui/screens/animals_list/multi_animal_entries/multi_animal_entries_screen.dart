// ignore_for_file: use_key_in_widget_constructors


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/enums/view_state.dart';
import '../../../custom_widgets/button/rounded_button.dart';
import '../../../custom_widgets/drop_down/custom_drop_down.dart';
import '../../../custom_widgets/text_feild/input_text_field.dart';
import 'multi_animal_entries_view_model.dart';

class MultiEntriesAnimalScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MultiEntriesAnimalViewModel(),
      child: Consumer<MultiEntriesAnimalViewModel>(
        builder:(context, model, child)=> ModalProgressHUD(
          inAsyncCall: model.state == ViewState.loading,
          progressIndicator: const CircularProgressIndicator(color: primaryColor,),
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: Text("Enter Animal Detail",
                  style: appBarTextStyle.copyWith(color: Colors.white)),
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    /// Animal Tag
                    _heading("Animal Tag"),

                    SizedBox(height: 6.h,),

                    InputTextField(
                      hintText: "Animal Tag",
                      validation: (String? val){
                        if(val!.isEmpty || val.length < 1){
                          return "Please Enter Animal Tag";
                        }if(val.length > 70){
                          return "Animal tag  should not be greater than 70 character";
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        model.animal.animalTag = val;
                        model.updateState();
                      },
                      controller: model.animalTagController,

                    ),

                    SizedBox(height: 10.h,),





                    /// Category
                    _heading("Animal Category"),

                    SizedBox(height: 6.h,),

                    DropDownMenu(
//                            selectedValue: ,
                      validator: (String? val){
                        if(val == null|| val.isEmpty){
                          return "Please Select Category";
                        }
                        else{
                          return null;
                        }
                      },
                      searchText: "Category",
                      searchList: model.category,
                      onSelected: (String? val){
                        model.animal.animalCategory = val;
                        model.updateState();
                      },
                    ),


                    SizedBox(height: 10.h,),


                    /// Category
                    _heading("Animal Type"),

                    SizedBox(height: 6.h,),

                    DropDownMenu(
//                            selectedValue: ,
                      validator: (String? val){
                        if(val == null|| val.isEmpty){
                          return "Please Animal Type";
                        }
                        else{
                          return null;
                        }
                      },
                      searchText: "Type",
                      searchList: model.animalTypes,
                      onSelected: (String? val){
                        model.animal.animalSex = val;
                        model.updateState();

                      },
                    ),


                    SizedBox(height: 10.h,),


                    /// Animal Range
                    _heading("Animal Range"),

                    SizedBox(height: 6.h,),

                    InputTextField(
                      validation: (String? val){
                        if(val!.isEmpty || val.length < 1){
                          return "Please Enter total Animal";
                        }
                        else{
                          return null;
                        }
                      },
                      hintText: "Total Animal",
                      onChanged: (val){},
                      inputType: TextInputType.number,
                      controller: model.totalAnimalController,

                    ),

//                Container(
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(8),
//                  ),
//                  child: SliderTheme(
//                    data: SliderThemeData(
//                      showValueIndicator: ShowValueIndicator.always,
//                      inactiveTrackColor: Colors.greenAccent.withOpacity(0.3),
//                      activeTrackColor: primaryColor,
//                      thumbColor: primaryColor,
//                      overlayColor: primaryColor.withOpacity(0.2),
//                    ),
//                    child: RangeSlider(
//                        values: model.rangeValues,
//                        min: 0,
//                        max: 100,
//                        divisions: 100,
//
//                        labels: RangeLabels(
//                            model.rangeValues.start.toInt().toString(),
//                            model.rangeValues.end.toInt().toString()),
//                        onChanged: (value) {
//                          model.updateRange(value);
////                        setState(() {
////                          widget.filter.isReset = false;
////                          ageRange = value;
////                        });
//                        }
//                        ),
//                  ),
//                ),




                    SizedBox(height: 30.h,),

                    Center(
                      child: RoundedButton(
                        width: 250.w,
                        textSize: 20,
                        text: "Save Information",
                        press: () async{
                          if(_formKey.currentState!.validate()){
                            await model.assignAnimalToList();
                            model.registerAnimalToServer();
                            Navigator.pop(context, model.animals);

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
      ),
    );
  }

  Widget _heading(String tag){
    return Text(tag, style: poppinTextStyle.copyWith(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
    ));
  }
}
