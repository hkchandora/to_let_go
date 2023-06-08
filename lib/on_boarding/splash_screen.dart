import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/on_boarding/login_screen.dart';
import 'package:to_let_go/on_boarding/splash_controller.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());
  String? versionName;
  Timer? timer;

  @override
  void initState() {
    getVersionInfo();
    startTime();
    super.initState();
  }

  getAppUpdateData() async {
    List appUpdateList = await splashController.getAppUpdateData();
    print(appUpdateList.toString());
    if(appUpdateList.isNotEmpty){
      String storeVersion = Platform.isAndroid ?
      appUpdateList[0]["androidVersion"]
          : appUpdateList[0]["iosVersion"];
      bool isUpdateAvailable = await splashController.canUpdateVersion(storeVersion, versionName);
      if(isUpdateAvailable){
        bool isForceUpdate = appUpdateList[0]["isForceUpdate"];
        String whatsNew = appUpdateList[0]["whatsNew"];
        // Utility().forceUpdatePopUp(context, isForceUpdate, whatsNew);
      }
    }
  }

  startTime() async {
    Duration duration = const Duration(seconds: 3);
    timer =  Timer(duration, (){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
    });
  }

  Future<void> getVersionInfo() async {
    String version = await Utility.getVersionInfo();
    setState(() {
      versionName = version;
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width)/4),
                child: Image.asset(AssetImagePath.appLogo),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text('Version $versionName'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
