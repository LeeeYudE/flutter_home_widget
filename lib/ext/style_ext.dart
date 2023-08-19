import 'package:flutter/material.dart';
import 'package:flutter_home_widget/ext/screen_ext.dart';


extension StyleExt on int {
  TextStyle textStyle(
    Color color, {
    bool bold = false,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      color: color,
      fontSize: this.sp,
      fontWeight: fontWeight ?? (bold ? FontWeight.bold : FontWeight.normal),
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
