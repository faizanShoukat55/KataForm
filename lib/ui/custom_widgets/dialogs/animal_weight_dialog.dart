// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/animal_weight.dart';
import '../../../core/services/time_handler_services.dart';
import '../button/rounded_button.dart';
import '../text_feild/input_text_field.dart';


class AnimalWeightDialog extends StatefulWidget {

  AnimalWeight? animalWeight;
  AnimalWeightDialog({this.animalWeight});
  @override
  State<AnimalWeightDialog> createState() => _AnimalWeightDialogState();
}

class _AnimalWeightDialogState extends State<AnimalWeightDialog> {


  late TextEditingController dateController ;

  late TextEditingController totalWeightController ;

  final _formKey = GlobalKey<FormState>();

  late AnimalWeight weight ;


  @override
  void initState() {
    // TODO: implement initState
    init();

    super.initState();
  }

  init(){

    if(widget.animalWeight == null){
      weight = AnimalWeight();


      dateController = TextEditingController(text: "${formatDateTimeOfHealth(DateTime.now())}");
      weight.weightDate = Timestamp.fromDate(DateTime.now());

      totalWeightController = TextEditingController();
    }else{
      weight = AnimalWeight.fromJson(widget.animalWeight!.toJson(), uid: widget.animalWeight!.animalWeightUid);


      dateController = TextEditingController(text: "${formatTimeStampOfHealth(widget.animalWeight!.weightDate!)}");

      totalWeightController = TextEditingController(text: "${widget.animalWeight!.totalKg}");

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

              Text("${widget.animalWeight == null ? "Add" : "Update"} Weight",
                style: poppinTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),),


              SizedBox(height: 9.h,),

              InputTextField(
                hintText: "Date",
                controller: dateController,
                isReadOnly: true,
                onTap: () async{
                  // DateTime(1000)
                  DateTime?  selectedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(), firstDate: DateTime(1000), lastDate: DateTime.now().add(Duration(days: 1000)));
                  if(selectedDate != null){
                    setState(() {
                      dateController = TextEditingController(text: "${formatDateTimeOfHealth(selectedDate)}");
                      weight.weightDate = Timestamp.fromDate(selectedDate);
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
                hintText: "Total Kg",
                inputType: TextInputType.number,
                controller: totalWeightController,
                onChanged: (val){
                  setState(() {
                    weight.totalKg = val;
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
                      text: widget.animalWeight == null ? "Add" : "Update",
                      press: (){
                        Navigator.pop(context,weight);

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
