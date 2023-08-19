import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../util/assets_util.dart';

//string_ext名称有问题，不知道为啥 索引不出来 改为string1_ext
extension StringNullExt on String? {
  String get nullSafe => this ?? '';

  bool isNotEmpty() => this != null && this!.isNotEmpty;

  bool get isGIF => this?.endsWith('.gif') ?? false;
}

extension StringExt on String {

  String fixAutoLines() {
    return Characters(this).join('\u{200B}');
  }



  void debugPrint() {
    print(this);
  }

  String get imgPath => AssetsUtils.getImgPath(this);
  String get logoPath => AssetsUtils.getLogoPath(this);
  String get svgPath => AssetsUtils.getSvgPath(this);

  // 匹配中括号的内容
  static final RegExp _regex = RegExp(r'\[([^\[\]]*)\]');
  static final RegExp _characterRegex = RegExp(r'[a-zA-Z]');

  String str({String? languageCode}) {
    return tr;
  }

  String strArgs(List<String> args) {
    assert(args.isNotEmpty);
    return trArgs(args);
  }

  bool get isAlpha => _characterRegex.hasMatch(this);

  bool get hasData => isNotEmpty;

  bool get noData => isEmpty;

  int get secureInt {
    try {
      if (isEmpty) {
        return 0;
      } else {
        return int.parse(this);
      }
    } catch (e) {
      print(e);
    }
    return 0;
  }

  double get secureDouble {
    try {
      if (isEmpty) {
        return 0;
      } else {
        return double.parse(this);
      }
    } catch (e) {
      print(e);
    }
    return 0;
  }

  // 计算文本占用宽高
  double paintWidthWithTextStyle(TextStyle style, {double? maxWidth}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: this, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth ?? double.infinity);
    return textPainter.size.width;
  }



  Color toColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
    return Colors.white;
  }

  String get suffix => lastIndexOf('.') != -1
      ? substring(lastIndexOf('.'), length).replaceAll('.', '')
      : '';

  String get filename => basename(this);

  bool get isImageName => isImageFileName || endsWith('webp');

  void copyText() {
    if(isNotEmpty){
      Clipboard.setData(ClipboardData(text: this));
    }

  }

}
