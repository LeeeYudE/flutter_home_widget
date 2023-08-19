import 'package:flutter/material.dart';
import 'package:flutter_home_widget/ext/string_ext.dart';


import '../res/colours.dart';

class CommonScaffold extends StatelessWidget {
  final Color? appBarColor; //状态栏颜色
  final Color? backGroundColor; //背景色
  final String? titleId; //标题Id
  final String? titleStr; //标题Id
  final Widget? body;
  final bool resizeToAvoidBottomInset; //软键盘是否顶起按钮
  final VoidCallback? backCallBack;
  final Widget? title;
  final String? lable;
  final bool whiteArrow;
  final Widget? bottom;
  final List<Widget>? actions;
  final Widget? leading; //返回箭头
  final double? elevation; //阴影
  final bool automaticallyImplyLeading; //是否需要返回箭头,不可见,但存在占位
  final Color? titleColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool leftArrowVisible; //左边箭头不可见,无占位符
  bool _leftArrowVisible = false;
  bool showAppbar = false;
  bool centerTitle = true;
  String? pageKey;
  Widget? floatingActionButton;
  Widget? bottomNavigationBar;

  CommonScaffold({
    Key? key,
    this.appBarColor,
    this.backGroundColor,
    this.titleId,
    this.titleStr,
    this.body,
    this.resizeToAvoidBottomInset = false,
    this.backCallBack,
    this.whiteArrow = false,
    this.title,
    this.lable,
    this.bottom,
    this.leading,
    this.elevation,
    this.automaticallyImplyLeading = true,
    this.leftArrowVisible = true,
    this.actions,
    this.titleColor,
    this.scaffoldKey,
    this.showAppbar = true,
    this.pageKey,
    this.centerTitle = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
  }) : super(key: key) {
    _leftArrowVisible = leftArrowVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backGroundColor ?? Colours.app_main,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      appBar: showAppbar
          ? AppBar(
              backgroundColor: appBarColor ?? Colours.app_main,
              //黑色状态栏,默认主题
              flexibleSpace: Container(color: appBarColor ?? Colours.app_main,),
              // systemOverlayStyle: SystemUiOverlayStyle.light,
              //去掉阴影
              elevation: elevation ?? 0.0,
              //标题居中
              centerTitle: centerTitle,
              automaticallyImplyLeading: _leftArrowVisible ? automaticallyImplyLeading : _leftArrowVisible,
              //返回箭头
              leading: _leftArrowVisible
                  ? (automaticallyImplyLeading ? (leading ?? _buildLeftArrow(context)) : Container())
                  : null,
              leadingWidth: leading != null ? 100 : null,
              //automaticallyImplyLeading: automaticallyImplyLeading
              actions: actions != null
                  ? [
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          children: actions!,
                        ),
                      )
                    ]
                  : null,
              //默认标题
              title: title ?? _buildTitle(context),
              bottom: bottom as PreferredSizeWidget?,
            )
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  IconButton _buildLeftArrow(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'ic_back'.imgPath,
        width: 20,
        height: 20,
      ),
      onPressed: backCallBack ??
          () {
            Navigator.pop(context);
          },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      lable ?? titleStr ?? titleId?.str() ?? '',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: titleColor ?? Colors.white,
      ),
    );
  }
}
