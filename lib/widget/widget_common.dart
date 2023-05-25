import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';

void printLog(String? log){
  if(kDebugMode){
    print(log);
  }
}

class ArrowToolbarBackwardNavigation extends StatelessWidget {
  const ArrowToolbarBackwardNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetImagePath.backButton,
      height: 24,
      width: 12,
      color: colorWhite,
    );
  }
}


class CrossBackwardNavigation extends StatelessWidget {
  const CrossBackwardNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetImagePath.crossButton,
      height: 18,
      width: 18,
      fit: BoxFit.fill,
      color: colorWhite,
    );
  }
}