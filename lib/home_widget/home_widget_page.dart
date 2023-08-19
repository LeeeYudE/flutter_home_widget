import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_home_widget/ext/decoration_color_ext.dart';
import 'package:flutter_home_widget/ext/screen_ext.dart';
import 'package:flutter_home_widget/ext/style_ext.dart';

import '../../res/colours.dart';
import '../base/base_getx.dart';
import '../base/common_scaffold.dart';
import '../widget/common_btn.dart';
import '../widget/tap_widget.dart';
import 'controller/home_widget_controller.dart';

/// 日期：2023/8/5
/// 作者：chakou
/// 描述：
class HomeWidgetPage extends BaseGetBuilder<HomeWidgetController> {
  static const String routeName = '/page/HomeWidgetPage';

  const HomeWidgetPage({super.key});

  @override
  HomeWidgetController? getController() => HomeWidgetController();

  @override
  Widget controllerBuilder(BuildContext context, HomeWidgetController controller) {
    return CommonScaffold(
      titleStr: 'Wallpaper',
      leftArrowVisible: false,
      body: _buildBody(context, controller),
    );
  }

  Widget _buildBody(BuildContext context, HomeWidgetController controller) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: _buildImages(context, controller)),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: CommonBtn(
                  lable: 'Save',
                  width: double.infinity,
                  backgroudColor: Colours.c_F7C35E,
                  textStyle: 16.textStyle(Colours.app_main),
                  onTap: () {
                    controller.complate();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImages(BuildContext context, HomeWidgetController controller) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1, mainAxisSpacing: 10.w, crossAxisSpacing: 10.w),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: Colours.c_3A3A3A.boxDecoration(),
                  child: TapWidget(
                    onTap: () {
                      controller.pickerImage();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colours.white_transparent,
                    ),
                  ));
            }
            index--;
            return Container(
              decoration: (index == controller.currentIndex ? Colours.c_F7C35E : Colours.white_transparent)
                  .borderDecoration(borderRadius: 12.w, width: 2.w),
              child: TapWidget(
                onTap: () {
                  controller.onPathSelected(index);
                },
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: Image.file(
                          File(controller.paths[index]),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(milliseconds:300 ),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: TapWidget(
                        onTap: () {
                          controller.deletePath(index);
                        },
                        child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: Colours.c_F30000.boxDecoration(borderRadius: 20.w),
                            child: const Icon(
                              Icons.close,
                              size: 12,
                              color: Colours.white,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: controller.paths.length + 1,
        ));
  }
}
