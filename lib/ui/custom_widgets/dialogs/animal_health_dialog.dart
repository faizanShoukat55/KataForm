// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/animal_health.dart';
import '../../../core/services/time_handler_services.dart';
import '../button/rounded_button.dart';
import '../text_feild/input_text_field.dart';


class AnimalHealthDialog extends StatefulWidget {
  
  AnimalHealth? health;
  AnimalHealthDialog({this.health});
  @override
  State<AnimalHealthDialog> createState() => _AnimalHealthDialogState();
}

class _AnimalHealthDialogState extends State<AnimalHealthDialog> {
  late TextEditingController titleController ;

  late TextEditingController priceController ;

  late TextEditingController dateController ;

  late TextEditingController descriptionController ;

  final _formKey = GlobalKey<FormState>();

  late AnimalHealth animalHealth ;


  @override
  void initState() {
    // TODO: implement initState
    init();

    super.initState();
  }
  
  init(){
    
    if(widget.health == null){
      animalHealth = AnimalHealth();
      titleController = TextEditingController();

      priceController = TextEditingController();

      dateController = TextEditingController(text: "${formatDateTimeOfHealth(DateTime.now())}");
      animalHealth.healthDate = Timestamp.fromDate(DateTime.now());

     descriptionController = TextEditingController();
    }else{
      animalHealth = AnimalHealth.fromJson(widget.health!.toJson(), widget.health!.animalHealthUid);
      titleController = TextEditingController(text: "${widget.health!.healthTitle}");

      priceController = TextEditingController(text: "${widget.health!.healthCost}");

      dateController = TextEditingController(text: "${formatTimeStampOfHealth(widget.health!.healthDate!)}");

      descriptionController = TextEditingController(text: "${widget.health!.healthTitle}");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 405.h,
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

              Text("Add Health Status",
              style: poppinTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),),

              SizedBox(height: 9.h,),

              InputTextField(
                maxLine: 1,
                maxLength: 50,
                hintText: "Health Title",
                controller: titleController,
                onChanged: (val){
                  setState(() {
                    animalHealth.healthTitle = val;
                  });
                },


              ),

              SizedBox(height: 9.h,),

            Row(
              children: [
                Flexible(
                  child: Container(
                    width: 150.w,
                    child:  InputTextField(
                      inputType: TextInputType.number,
                      hintText: "RS",
                      controller: priceController,
                      onChanged: (val){
                        setState(() {
                          animalHealth.healthCost = val;
                        });                      },


                    ),
                  ),
                ),

                SizedBox(width: 25.w,),

                Expanded(
                  child: InputTextField(
                    hintText: "Date",
                    controller: dateController,
                    isReadOnly: true,
                    onTap: () async{
                      // .add(Duration(days: 1000))
                      DateTime?  selectedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(), firstDate: DateTime(1000), lastDate: DateTime.now());
                      if(selectedDate != null){
                        setState(() {
                          dateController = TextEditingController(text: "${formatDateTimeOfHealth(selectedDate)}");
                          animalHealth.healthDate = Timestamp.fromDate(selectedDate);
                        });
                      }


                    },
                    onChanged: (val){
                      setState(() {
//                        animalHealth.d = val;
                      });
                    },


                  ),
                ),

              ],
            ),


              SizedBox(height: 9.h,),

              InputTextField(
                maxLine: 3,
                hintText: "Description",
                controller: descriptionController,
                onChanged: (val){
                  setState(() {
                    animalHealth.healthDescription = val;
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
                      text: widget.health == null ? "Add" : "Update",
                      press: (){
                        Navigator.pop(context,animalHealth);

//                      Get.to(()=> MultiEntriesAnimalScreen());
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
