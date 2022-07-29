import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_planner_frontend/app/shared/fonts.dart';

class KCustomTextStyle {
  static kBold(BuildContext context, double fontSize, [Color? color]) =>
      KConstantFonts.poppinsBold.copyWith(
        fontSize: fontSize.sp,
        color: color,
      );
  /* static kBoldWhite(BuildContext context, double fontSize) => TextStyle(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.bold,
      color: KConstantColors.whiteColor); */
  static kMedium(BuildContext context, double fontSize, [Color? color]) =>
      KConstantFonts.poppinsMedium.copyWith(
        fontSize: fontSize.sp,
        color: color,
      );
}
