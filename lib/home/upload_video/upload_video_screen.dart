import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Upload video screen",
          style: extraBoldTextStyleWhite_18,
        ),
      ),
    );
  }
}
