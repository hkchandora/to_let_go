import 'package:flutter/material.dart';
import 'package:to_let_go/home/follower/user_follower_screen.dart';
import 'package:to_let_go/home/following/user_following_screen.dart';

class UserAllData extends StatefulWidget {
  const UserAllData({Key? key}) : super(key: key);

  @override
  State<UserAllData> createState() => _UserAllDataState();
}

class _UserAllDataState extends State<UserAllData> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('user_name'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Following"),
              Tab(text: "Followers"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserFollowingsScreen(),
            UserFollowersScreen(),
          ],
        ),
      ),
    );
  }
}