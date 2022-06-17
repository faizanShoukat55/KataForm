
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/text_styles.dart';


class DropDownMenu extends StatelessWidget {
  final String? searchText;
  final List? searchList;
  final  selectedValue;
  final  onSelected;
  final validator;
  final bool setBorder;


  DropDownMenu({
    this.searchText,
    this.searchList,
    this.selectedValue,
    this.onSelected,
    this.validator,
    this.setBorder = false,
  });


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: false,
        child: DropdownButtonFormField<String>(

          menuMaxHeight: 300,
          style: poppinTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: Colors.black,
          ),

//        onTap: onSelected,
        isExpanded: true,

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            filled: true,
            fillColor: Colors.white,
            border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
          ),
          validator: validator,
          hint: Text(searchText!),

          items: searchList!.map((dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem,
                style: poppinTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: onSelected,
          value: selectedValue,
          //underline: SizedBox(),
        ),
      ),
    );
  }
}
