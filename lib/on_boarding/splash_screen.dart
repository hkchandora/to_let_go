import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_let_go/on_boarding/login_screen.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String? versionName;
  Timer? timer;

  @override
  void initState() {
    getVersionInfo();
    startTime();
    super.initState();
  }

  startTime() async {
    Duration duration = const Duration(seconds: 3);
    timer =  Timer(duration, (){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
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
