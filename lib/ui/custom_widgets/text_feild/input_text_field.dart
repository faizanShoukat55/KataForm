// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/text_styles.dart';


class InputTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool isPasswordActive;
  final  validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final  onChanged;
  final  onSave;
  final VoidCallback? onTap;
  final int? maxLine;
  final TextInputType? inputType;
  final bool isReadOnly;
  final LengthLimitingTextInputFormatter? limitingTextInputFormatter;
  final int? maxLength;

  InputTextField({this.hintText, this.labelText, this.controller, this.limitingTextInputFormatter,
  this.onTap, this.onChanged, this.onSave, this.inputAction = TextInputAction.next,
    this.inputType= TextInputType.emailAddress, this.isPasswordActive = false, this.maxLine = 1, this.prefixIcon, this.isReadOnly = false,
  this.suffixIcon, this.validation,this.maxLength});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFormField(
          inputFormatters: [
            limitingTextInputFormatter != null ? limitingTextInputFormatter! : LengthLimitingTextInputFormatter(300),
          ],
          maxLength: maxLength,
          readOnly: isReadOnly,
          onTap: onTap ?? (){},
          onChanged: onChanged,
          onFieldSubmitted: onSave,
          validator: validation,
          controller: controller == null ?TextEditingController(): controller!,
          obscureText: isPasswordActive,
          textInputAction: inputAction,
          keyboardType: inputType!,
          maxLines: maxLine,
          cursorColor: Colors.black,
          style: poppinTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: poppinTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Colors.black.withOpacity(0.5),
            ),

            labelText: labelText,
            labelStyle: poppinTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.black,
            ),

            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            suffixIcon: suffixIcon == null ? Container(width: 1.w,) : Padding(
              padding:  EdgeInsets.only(right:10.0),
              child: suffixIcon!,
            ),
            suffixIconConstraints: BoxConstraints(
              maxWidth: 35.sp,
              maxHeight: 35.sp,
            ),
//        prefix: prefixIcon == null ? Container() : prefixIcon!,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white,
                ),

            ),
          ),

        ),
      ],
    );
  }
}
