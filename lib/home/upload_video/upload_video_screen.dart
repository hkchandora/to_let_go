import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {

  displayDialogBox(){
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: (){},
            child: Row(
              children: const [
                Icon(Icons.image),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Get Video from Phone Gallery",
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: (){},
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Make Video with Phone Camera",
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Get.back();
            },
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Cancel",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetImagePath.profileAvatar,
              width: 260,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                displayDialogBox();
              },
              style: ElevatedButton.styleFrom(
                primary: colorGreen,
                elevation: 0,
              ),
              child: const Text("Upload New Video",
                style: TextStyle(fontSize: 16, color: colorWhite, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
