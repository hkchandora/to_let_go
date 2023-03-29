import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:to_let_go/util/widget_common.dart';

class Utility {

  static Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    printLog('version ==> $version');
    return version;
  }

}