import 'package:flutter/cupertino.dart';

class TapWidget extends StatelessWidget {
  ///防止重复点击
  static const int CLICK_TIME = 200;

  Widget child;
  GestureTapCallback onTap;
  int _lastClickTime = 0;
  bool enable;

  TapWidget(
      {Key? key, required this.child, required this.onTap, this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (enable) {
          var dateTimeNowMilli = DateTime.now().millisecondsSinceEpoch;
          if (dateTimeNowMilli - _lastClickTime > CLICK_TIME) {
            _lastClickTime = dateTimeNowMilli;
            onTap.call();
          }
        }
      },
      child: child,
    );
  }
}
