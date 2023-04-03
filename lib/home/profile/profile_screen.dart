import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class ProfileScreeb extends StatefulWidget {
  const ProfileScreeb({Key? key}) : super(key: key);

  @override
  State<ProfileScreeb> createState() => _ProfileScreebState();
}

class _ProfileScreebState extends State<ProfileScreeb> {
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
