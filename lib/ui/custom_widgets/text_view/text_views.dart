
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katta_form/ui/custom_widgets/text_view/text_styles.dart';

Text textView8(
    {required String text,
      FontWeight fontWeight = FontWeight.w500,
      required Color textColor ,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 1,
    style: titleTextStyle.copyWith(
      fontSize: 8.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}

Text textView10(
    {required String text,
      FontWeight fontWeight = FontWeight.w500,
      required Color textColor,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 1,
    style: titleTextStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}

Text textView12(
    {required String text,
      FontWeight fontWeight = FontWeight.w600,
      required Color textColor ,
      double wordSpacing = 1,
      int maxLines = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    maxLines: maxLines,
    textAlign: textAlign,
    style: titleTextStyle.copyWith(
      fontSize: 12.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}


Text textView14(
    {required String text,
      FontWeight fontWeight = FontWeight.w500,
      required Color textColor ,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    maxLines: 2,
    textAlign: textAlign,
    style: titleTextStyle.copyWith(
      overflow: TextOverflow.ellipsis,
      fontSize: 14.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}



Text textView16(
    {int maxLine=1,
      required String text,
      FontWeight fontWeight = FontWeight.w500,
      required Color textColor ,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 2,
    style: titleTextStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}




Text textView18(
    {required String text,
      FontWeight fontWeight = FontWeight.w600,
      required Color textColor ,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 2,

    style: titleTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}



Text textView20(
    {required String text,

      FontWeight fontWeight = FontWeight.w600,
      required Color textColor,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 2,
    style: titleTextStyle.copyWith(
      fontSize: 20.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}


Text textView24(
    {required String text,

      FontWeight fontWeight = FontWeight.w600,
      required Color textColor ,
      double wordSpacing = 1,
      TextAlign? textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 2,
    style: titleTextStyle.copyWith(
      fontSize: 24.sp,
      fontWeight: fontWeight,
      color: textColor,
      // letterSpacing: 1,
      fontFamily: 'Roboto',
      wordSpacing: wordSpacing,
    ),
  );
}
