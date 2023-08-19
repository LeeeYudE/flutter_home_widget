import 'package:flutter/cupertino.dart';

extension DecorationColorExt on Color {
  Widget toLine(double height, {double? width}) {
    return Container(
      color: this,
      height: height,
      width: width ?? double.infinity,
    );
  }

  Widget toLineW(double? width, {double? height}) {
    return Container(
      color: this,
      width: width,
      height: height ?? double.infinity,
    );
  }

  Decoration boxDecoration(
      {double? borderRadius, Color? borderColor, double? borderWidth}) {
    return BoxDecoration(
        color: this,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth ?? 1)
            : null);
  }

  Decoration borderDecoration(
      {double? borderRadius, double width = 1, Color? bgColor}) {
    return BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
        border: Border.all(color: this, width: width));
  }

  Decoration radiusDecoration(
      {double? topLeft,
      double? topRight,
      double? bottomLeft,
      double? bottomRight}) {
    return BoxDecoration(
      color: this,
      borderRadius: BorderRadius.only(
          topLeft: topLeft != null ? Radius.circular(topLeft) : Radius.zero,
          topRight: topRight != null ? Radius.circular(topRight) : Radius.zero,
          bottomLeft:
              bottomLeft != null ? Radius.circular(bottomLeft) : Radius.zero,
          bottomRight:
              bottomRight != null ? Radius.circular(bottomRight) : Radius.zero),
    );
  }

  Decoration bottomBorder(
      {double? width, Color? bgColor, bool bottom = true, bool top = false}) {
    return BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: bottom
              ? BorderSide(color: this, width: width ?? 1)
              : BorderSide.none,
          top: top
              ? BorderSide(color: this, width: width ?? 1)
              : BorderSide.none,
        ));
  }


}
