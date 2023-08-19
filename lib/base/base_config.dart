import 'package:flustars/flustars.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';


class BaseConfig {
  // 页面的初始化下标是1
  static const PAGE_SIZE = 20;
  static bool DEBUG = !const bool.fromEnvironment('dart.vm.product');
  static bool DEVELOPER_MODE = false;
  static const bool kReleaseMode = bool.fromEnvironment('dart.vm.product', defaultValue: false);
  static const bool kProfileMode = bool.fromEnvironment('dart.vm.profile', defaultValue: false);

  /// 是否从 Testflight 或 ipa 安装，安装包可能是同一个，只是安装方式不同。非 iOS 始终返回 [false]
  static bool isTest = false;
  static bool isMacOs = GetPlatform.isMacOS;
  static bool isIOS = GetPlatform.isIOS;
  static bool isAndroid = GetPlatform.isAndroid;
  static bool isMobile = GetPlatform.isMobile;
  static bool isDesktop = GetPlatform.isDesktop;

  static const IMEI = 'utma';
  static String imeiId = 'utma_uuid';

  static String APP_VERSION = '1.0.0';

  /// app 版本名
  static String APP_VERSION_CODE = '1.0.0(80)';

  /// app 版本号
  static String OS = 'android';

  /// 手机系统
  static String OS_VERSION = '';

  /// 系统版本 android 12
  static String OS_SDK = '';
  static int get  OS_SDK_INT => int.tryParse(OS_SDK)??0;


  static String LANG = 'zh-cn';
  static const String theme = 'AppTheme';
  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    APP_VERSION = packageInfo.version;
    APP_VERSION_CODE = packageInfo.buildNumber;
    if (isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      OS_VERSION = androidInfo.version.release;
      OS_SDK = '${androidInfo.version.sdkInt}';
      await SpUtil.getInstance();
    }
  }
}
