import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Center(
           child: Text(
             "Like video screen",
             style: extraBoldTextStyleWhite_18,
           ),
       ),
    );
  }
}
