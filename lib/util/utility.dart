import 'package:package_info_plus/package_info_plus.dart';
import 'package:to_let_go/widget/widget_common.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {

  static Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    printLog('version ==> $version');
    return version;
  }

  static Future<bool> launchGivenUrl(String url) async {
    printLog("url");
    printLog(url);
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
    return true;
  }

}