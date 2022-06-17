// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/animal_milk.dart';
import '../../../core/services/time_handler_services.dart';
import '../button/rounded_button.dart';
import '../text_feild/input_text_field.dart';


class AnimalMilkDialog extends StatefulWidget {

  AnimalMilk? animalMilk;
  AnimalMilkDialog({this.animalMilk});
  @override
  State<AnimalMilkDialog> createState() => _AnimalMilkDialogState();
}

class _AnimalMilkDialogState extends State<AnimalMilkDialog> {


  late TextEditingController milkDateController ;
  late TextEditingController firstTimeController ;
  late TextEditingController secondTimeController ;
  late TextEditingController thirdTimeController ;


  final _formKey = GlobalKey<FormState>();

  late AnimalMilk milk ;


  @override
  void initState() {
    // TODO: implement initState
    init();

    super.initState();
  }

  init(){

    if(widget.animalMilk == null){
      milk = AnimalMilk();


      milkDateController = TextEditingController(text: "${formatDateTimeOfHealth(DateTime.now())}");
      milk.milkDate = Timestamp.fromDate(DateTime.now());
      firstTimeController = TextEditingController();
      secondTimeController = TextEditingController();
      thirdTimeController = TextEditingController();

    }else{
      milk = AnimalMilk.fromJson(widget.animalMilk!.toJson(), id :widget.animalMilk!.animalMilkID);

      milkDateController = TextEditingController(text: "${formatTimeStampOfHealth(widget.animalMilk!.milkDate!)}");
      firstTimeController = TextEditingController(text: "${widget.animalMilk!.milkFirstTime}");
      secondTimeController = TextEditingController(text: "${widget.animalMilk!.milkSecondTime}");
      thirdTimeController = TextEditingController(text: "${widget.animalMilk!.milkThirdTime}");


    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 401.h,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xffE5E5E5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("${widget.animalMilk == null ? "Add" : "Update"} Milk Record",
                style: poppinTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),),

          
              SizedBox(height: 9.h,),

              InputTextField(
                hintText: "Date",
                controller: milkDateController,
                isReadOnly: true,
                onTap: () async{
                  // .add(Duration(days: 1000)
                  DateTime?  selectedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(), firstDate: DateTime(1000), lastDate: DateTime.now());
                  if(selectedDate != null){
                    setState(() {
                      milkDateController = TextEditingController(text: "${formatDateTimeOfHealth(selectedDate)}");
                      milk.milkDate = Timestamp.fromDate(selectedDate);
                    });
                  }


                },
                onChanged: (val){
                  setState(() {
//                        animalHealth.d = val;
                  });
                },


              ),


              SizedBox(height: 9.h,),

              InputTextField(
                maxLine: 1,
                inputType: TextInputType.number,
                hintText: "First Time milk in kg",
                controller: firstTimeController,
                onChanged: (val){
                  setState(() {
                    milk.milkFirstTime = val;
                  });
                },
                
              ),


              SizedBox(height: 9.h,),

              InputTextField(
                maxLine: 1,
                inputType: TextInputType.number,
                hintText: "Second Time milk in kg",
                controller: secondTimeController,
                onChanged: (val){
                  setState(() {
                    milk.milkSecondTime = val;
                  });
                },

              ),


              SizedBox(height: 9.h,),

              InputTextField(
                maxLine: 1,
                inputType: TextInputType.number,
                hintText: "Third Time milk in kg",
                controller: thirdTimeController,
                onChanged: (val){
                  setState(() {
                    milk.milkThirdTime = val;
                  });
                },

              ),




              SizedBox(height: 19.h,),


              Row(
                children: [
                  Expanded(
                    child: RoundedButton(
                      text: "Cancel",
                      textSize: 15,
                      textColor: Colors.white,
                      color: lightSilverColor,
                      press: () {
                        Navigator.pop(context,null);
                      },
                    ),),

                  SizedBox(width: 10.w,),

                  Expanded(
                    child: RoundedButton(
                      textSize: 15,
                      text: widget.animalMilk == null ? "Add" : "Update",
                      press: (){
//                        if(_formKey.currentState!.validate()){
                          int totalKg = int.parse("${(milk.milkFirstTime == null || milk.milkFirstTime!.isEmpty) ? "0" : milk.milkFirstTime }")
                              +  int.parse("${(milk.milkSecondTime == null || milk.milkSecondTime!.isEmpty) ? "0" : milk.milkSecondTime }")
                              +  int.parse("${(milk.milkThirdTime == null || milk.milkThirdTime!.isEmpty) ? "0" : milk.milkThirdTime }");
                          milk.totalMilk = totalKg;
                          Navigator.pop(context,milk);

//                        }

                      },
                    ),),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
