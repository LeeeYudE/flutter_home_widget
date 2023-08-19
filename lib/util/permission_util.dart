import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_exif_plugin/flutter_exif_plugin.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/base_config.dart';

class PermissionUtil {
  static Future<bool> requsuetPermissions(List<Permission> list) async {
    Map<Permission, PermissionStatus> statuses = await list.request();
    statuses.removeWhere((key, value) => value.isGranted);
    return statuses.isEmpty;
  }

  static Future<bool> requsuetPermission(Permission permission) async {
    PermissionStatus statuses = await permission.request();
    return statuses.isGranted;
  }

  static Future<bool> hasPermission(Permission permission) async {
    PermissionStatus statuses = await permission.status;
    return statuses.isGranted;
  }

  static Future<bool> requsuetStorage() async {
    if((int.tryParse(BaseConfig.OS_SDK)??0) >= 33){
      return true;
    }
    return requsuetPermission(Permission.storage);
  }


  static Future<bool> requsuetPhoto() {
    return requsuetPermission((BaseConfig.OS_SDK_INT >= 33) ? Permission.photos : Permission.storage);
  }

  ///请求相机
  static Future<bool> requestCamera() {
    return PermissionUtil.requsuetPermissions(
        [Permission.camera, Permission.microphone]);
  }

  static Future<String?> pickerImage() async {
    var bool = await PermissionUtil.requsuetPhoto();
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
        return path;
      }
    }
    return null;
  }

}
