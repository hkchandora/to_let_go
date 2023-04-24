import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class ForYouVideoScreen extends StatefulWidget {
  const ForYouVideoScreen({Key? key}) : super(key: key);

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "For You video screen",
          style: extraBoldTextStyleWhite_18,
        ),
      ),
    );
  }
}

