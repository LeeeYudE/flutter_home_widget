import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ViewState { Init, Idle, Busy, Error, Empty }

abstract class BaseGetBuilderState<T extends StatefulWidget,V extends GetxController> extends State<T> with AutomaticKeepAliveClientMixin {

  late V controller;

  @override
  void initState() {
    controller = (getController()??(GetInstance().find<T>(tag: getTag())) as V);
    super.initState();
  }

  getWantKeepAlive() => true;

  @override
  bool get wantKeepAlive => getWantKeepAlive();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<V>(
        init: controller,
        tag: getTag(),
        builder: (controller) {
          return controllerBuilder(context, controller);
        });
  }

  Widget controllerBuilder(BuildContext context, V controller);

  String? getTag() => null;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  V? getController();

}

///获取controller的 baseView, 这里要在路由里声明 controller
abstract class BaseGetBuilder<T extends GetxController> extends GetView<T> {
  const BaseGetBuilder({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
    return super.createElement();
  }

  String? getTag() => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
        init: getController() ?? Get.find<T>(tag: getTag()),
        tag: getTag(),
        dispose: (state) {
          dispose(state);
        },
        builder: (controller) {
          return controllerBuilder(context, controller);
        });
  }

  void dispose(GetBuilderState<T> state) {}

  Widget controllerBuilder(BuildContext context, T controller);

  T? getController();

  ///ui build之前，可以设置数据
  void onInit() {}

  ///初始化数据
  void onReady() {}

  void update() {
    controller.update();
  }
}

///Controller
abstract class BaseXController extends GetxController {

  ViewState state = ViewState.Init;
  bool isDispose = false;

  bool isBusyState() => state == ViewState.Busy;
  bool isInitState() => state == ViewState.Init;

  setBusyState() => setState(ViewState.Busy);
  setIdleState() => setState(ViewState.Idle);
  setEmptyState() => setState(ViewState.Empty);
  setErrorState() => setState(ViewState.Error);

  void setState(ViewState state) {
    if (this.state != state) {
      this.state = state;
      update();
    }
  }

  ///第一帧未回调的方法
  @override
  void onInit() {
    super.onInit();
  }

  ///第一帧已回调的方法
  @override
  void onReady() {
    super.onReady();
  }

  @override
  @mustCallSuper
  onClose() {
    super.onClose();
    isDispose = true;
  }


}

///Bindings
abstract class BaseBindings extends Bindings {}
