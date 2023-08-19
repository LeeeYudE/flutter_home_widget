import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_plugin/flutter_exif_plugin.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_home_widget/ext/string_ext.dart';
import 'package:home_widget/home_widget.dart';
import '../../../util/permission_util.dart';
import '../../base/base_getx.dart';

/// 日期：2023/8/5
/// 作者：chakou
/// 描述：
///

class HomeWidgetController extends BaseXController{

  static const String _providerName = 'HomeScreenWidgetProvider';

  List<String> paths = [];
  int currentIndex = -1;

  @override
  void onInit() {
    paths.addAll(SpUtil.getStringList('wallpaper')??[]);
    _init();
    super.onInit();
  }

  Future<void> _init() async {
    currentIndex =  (await HomeWidget.getWidgetData('path_index', defaultValue: 0))??0;
    debugPrint('currentIndex:$currentIndex');
    update();
  }

  pickerImage() async {
    var bool = await PermissionUtil.requsuetPhoto();
   'pickerImage:$bool'.debugPrint();
    if (bool) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image,allowCompression: false);
      if (result != null) {
        String path = result.files.first.path!;
        var flutterExif = FlutterExif.fromPath(path);
        int? exitRotationDegrees = await flutterExif.getRotationDegrees();
        if(exitRotationDegrees != null && exitRotationDegrees != 0){
          File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: path);
          path = rotatedImage.path;
        }
       if(!paths.contains(path)){
         paths.add(path);
         update();
       }
      }
    }
  }

  onPathSelected(int index){
    currentIndex = index;
    update();
  }

  deletePath(int index){
    if(currentIndex == index){
      currentIndex = 0;
    }
    paths.removeAt(index);
    update();
  }

  Future<void> complate() async {
    var saveWidgetData =  await HomeWidget.saveWidgetData<String>('paths', paths.join(','));
    '_saveWidgetData:$saveWidgetData'.debugPrint();
    await HomeWidget.saveWidgetData('path_index', currentIndex);
    await HomeWidget.saveWidgetData('last_show_time', null);
    var updateWidget = await HomeWidget.updateWidget(name: _providerName, iOSName: _providerName);
    '_saveWidgetData:$updateWidget'.debugPrint();
    SpUtil.putStringList('wallpaper',paths);
    SystemNavigator.pop();
  }

}