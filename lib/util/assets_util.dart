import 'package:flutter/material.dart';

class AssetsUtils {
  /// 获取图片位置
  static String getImgPath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getLogoPath(String name, {String format = 'png'}) {
    return 'assets/logos/$name.$format';
  }

  static String getSvgPath(String name, {String format = 'svg'}) {
    return 'assets/svg/$name.$format';
  }

  /// 获取屏幕宽度 */
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 获取屏幕高度
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 获取系统状态栏高度
  static double getSysStatsHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// 顶部应用栏高度
  static double getAppBarHeight() {
    return kTextTabBarHeight;
  }
}
