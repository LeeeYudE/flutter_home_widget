import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_widget/base/base_config.dart';
import 'package:flutter_home_widget/res/colours.dart';
import 'package:get/get.dart';

import 'app_pages.dart';
import 'home_widget/home_widget_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colours.c_F7C35E,
        useMaterial3: true,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colours.c_F7C35E),
          checkColor: MaterialStateProperty.all(Colours.app_main),
        ),
      ),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      themeMode: ThemeMode.dark,
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colours.c_F7C35E,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colours.c_F7C35E),
          checkColor: MaterialStateProperty.all(Colours.app_main),
        ),
      ),
      defaultTransition: Transition.cupertino,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        setDesignWHD(size.width, size.height);
        return child!;
      },
    );
  }
}
