import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Center(
           child: Text(
             "Follower video screen",
             style: extraBoldTextStyleWhite_18,
           ),
       ),
    );
  }
}
