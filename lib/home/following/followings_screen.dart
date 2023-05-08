import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class FollowingsScreen extends StatefulWidget {
  const FollowingsScreen({Key? key}) : super(key: key);

  @override
  State<FollowingsScreen> createState() => _FollowingsScreenState();
}

class _FollowingsScreenState extends State<FollowingsScreen> {
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
