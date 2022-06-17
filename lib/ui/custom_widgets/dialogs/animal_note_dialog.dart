// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/animal_note.dart';
import '../../../core/services/time_handler_services.dart';
import '../button/rounded_button.dart';
import '../text_feild/input_text_field.dart';


class AnimalNoteDialog extends StatefulWidget {

  AnimalNote? animalNote;
  AnimalNoteDialog({this.animalNote});
  @override
  State<AnimalNoteDialog> createState() => _AnimalNoteDialogState();
}

class _AnimalNoteDialogState extends State<AnimalNoteDialog> {
  late TextEditingController titleController ;


  late TextEditingController dateController ;

  late TextEditingController descriptionController ;

  final _formKey = GlobalKey<FormState>();

  late AnimalNote note ;


  @override
  void initState() {
    // TODO: implement initState
    init();

    super.initState();
  }

  init(){

    if(widget.animalNote == null){
      note = AnimalNote();
      titleController = TextEditingController();


      dateController = TextEditingController(text: formatDateTimeOfHealth(DateTime.now()));
      note.noteDate = Timestamp.fromDate(DateTime.now());

      descriptionController = TextEditingController();
    }else{
      note = AnimalNote.fromJson(widget.animalNote!.toJson(), uid: widget.animalNote!.animalNoteUid);
      titleController = TextEditingController(text: "${widget.animalNote!.noteTitle}");


      dateController = TextEditingController(text: formatTimeStampOfHealth(widget.animalNote!.noteDate!));

      descriptionController = TextEditingController(text: "${widget.animalNote!.noteDescription}");

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

              Text("${widget.animalNote == null ? "Add" : "Update"} Note",
                style: poppinTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),),

              SizedBox(height: 9.h,),

              InputTextField(
                hintText: "Note Title",
                controller: titleController,
                maxLength: 50,
                onChanged: (val){
                  setState(() {
                    note.noteTitle = val;
                  });
                },


              ),

              SizedBox(height: 9.h,),

              InputTextField(
                hintText: "Date",
                controller: dateController,
                isReadOnly: true,
                onTap: () async{
                  DateTime?  selectedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(), firstDate: DateTime(1000), lastDate: DateTime.now().add(Duration(days: 1000)));
                  if(selectedDate != null){
                    setState(() {
                      dateController = TextEditingController(text: "${formatDateTimeOfHealth(selectedDate)}");
                      note.noteDate = Timestamp.fromDate(selectedDate);
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
                maxLine: 3,
                hintText: "Description",
                controller: descriptionController,
                onChanged: (val){
                  setState(() {
                    note.noteDescription = val;
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
                      text: widget.animalNote == null ? "Add" : "Update",
                      press: (){
                        Navigator.pop(context,note);

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
