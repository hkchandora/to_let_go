import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  forceUpdatePopUp(BuildContext context, bool isForceUpdate, String storeWhatsNew) {
    return showDialog(
      context: context,
      barrierDismissible: isForceUpdate ? false : true,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if(isForceUpdate) {
              SystemNavigator.pop();
              return false;
            } else {
              return true;
            }
          },
          child: Platform.isAndroid ? AlertDialog(
            title: const Text('Update Available!'),
            content:Text("New version of the app is available; Kindly update the app to continue.\n\nWhat's New: \n$storeWhatsNew"),
            actions: <Widget>[
              isForceUpdate ? const SizedBox() : MaterialButton(
                child: const Text('Not Now', style: TextStyle(color:Colors.blue),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text(isForceUpdate ? 'Update Now' : 'Update', style: const TextStyle(color:Colors.blue)),
                onPressed: () {
                  Utility.launchGivenUrl("https://play.google.com/store/apps/details?id=com.himanshu.toletgo");
                },
              )
            ],
          ) : CupertinoAlertDialog(
            title: const Text('Update Available!'),
            content:Text("New version of the app is available; Kindly update the app to continue.\n\nWhat's New: \n$storeWhatsNew"),
            actions: <Widget>[
              isForceUpdate ? Column(
                children: [
                  CupertinoDialogAction(
                    child: const Text("Update Now", style: TextStyle(color:Colors.blue),),
                    onPressed: () {
                      Utility.launchGivenUrl("https://apps.apple.com/in/app/spark-loans/id1551799259?uo=4");
                    },
                  ),
                ],
              ) : Column(
                children: [
                  CupertinoDialogAction(
                    child: const Text("Not Now", style: TextStyle(color:Colors.blue),),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text("Update Now", style: TextStyle(color:Colors.blue),),
                    onPressed: () {
                      Utility.launchGivenUrl("https://apps.apple.com/in/app/spark-loans/id1551799259?uo=4");
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}