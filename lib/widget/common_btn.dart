import 'package:flutter/material.dart';
import 'package:flutter_home_widget/ext/decoration_color_ext.dart';
import 'package:flutter_home_widget/ext/screen_ext.dart';
import 'package:flutter_home_widget/ext/style_ext.dart';
import 'package:flutter_home_widget/widget/tap_widget.dart';

import '../../res/colours.dart';

class CommonBtn extends StatelessWidget {
  final String lable;
  final GestureTapCallback onTap;
  final TextStyle? textStyle;
  final Color? backgroudColor;
  final double? width;
  final double? height;
  final Widget? icon;
  final bool enable;

  const CommonBtn(
      {required this.lable,
      required this.onTap,
      this.width,
      this.height,
      this.textStyle,
      this.backgroudColor,
      this.icon,
      this.enable = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapWidget(
        onTap: onTap,
        enable: enable,
        child: Container(
          decoration: (backgroudColor ?? Colours.c_F7C35E).withOpacity(enable? 1 : 0.7)
              .boxDecoration(borderRadius: 6),
          width: width ?? 72,
          height: height ?? 48,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Padding(padding: EdgeInsets.only(right: 5.w), child: icon),
                Text(
                  lable,
                  style: textStyle ?? 14.textStyle(Colours.c_333333,fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }
}
