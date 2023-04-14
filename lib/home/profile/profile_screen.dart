import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Profile screen",
          style: extraBoldTextStyleWhite_18,
        ),
      ),
    );
  }
}
