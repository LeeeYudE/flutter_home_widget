
import 'package:get/get.dart';

import 'home_widget/home_widget_page.dart';

class AppPages {
  static const INITIAL = HomeWidgetPage.routeName;

  static final List<GetPage> routes = [
    _page(
      name: HomeWidgetPage.routeName,
      page: () => HomeWidgetPage(),
    ),
  ];


  static GetPage _page({
    required String name,
    required GetPageBuilder page,
    List<GetMiddleware>? middlewares,
    bool fullscreenDialog = false,
    bool popGesture = true,
  }) {
    return GetPage(
        name: name,
        middlewares: middlewares,
        fullscreenDialog: fullscreenDialog,
        popGesture: popGesture,
        gestureWidth: (_) => popGesture ? Get.width * 0.3 : 0,
        page: () {
          return page();
        });
  }
}
