import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class FollowingsVideoScreen extends StatefulWidget {
  const FollowingsVideoScreen({Key? key}) : super(key: key);

  @override
  State<FollowingsVideoScreen> createState() => _FollowingsVideoScreenState();
}

class _FollowingsVideoScreenState extends State<FollowingsVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Center(
           child: Text(
             "Followings video screen",
             style: extraBoldTextStyleWhite_18,
           ),
       ),
    );
  }
}
