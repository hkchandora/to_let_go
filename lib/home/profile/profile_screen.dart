import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Profile screen",
            style: extraBoldTextStyleWhite_18,
          ),
          const SizedBox(height: 50),
          MaterialButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text("Log out"),
          )
        ],
      ),
    );
  }
}
