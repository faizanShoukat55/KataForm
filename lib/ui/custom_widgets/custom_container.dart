import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;

  const CustomContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // decoration: BoxDecoration(
      //     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      //     border: Border.all(
      //       color: lightGreyColor,
      //       width: 1,
      //     )),
      //
      // padding: EdgeInsets.symmetric(
      //     horizontal: size.width * 0.03,),

      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        border: Border.all(
          color: lightGreyColor,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: lightGreyColor,
            offset: Offset(0.0, 0.1), //(x,y)
            // blurRadius: 1.0,
          ),
        ],
      ),

      child: child,
    );
  }
}
