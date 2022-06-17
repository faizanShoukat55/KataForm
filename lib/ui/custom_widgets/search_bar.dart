
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class SearchBar extends StatelessWidget {
  final  onPress;
  final String? hintText;
  SearchBar({required this.onPress, this.hintText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: poppinTextStyle.copyWith(
          fontSize: 15.sp,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: 25.sp,
          color: Colors.blueGrey,
        ),
//
      ),
      onChanged: onPress,
    );
  }
}