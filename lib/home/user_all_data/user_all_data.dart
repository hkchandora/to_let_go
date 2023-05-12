import 'package:flutter/material.dart';
import 'package:to_let_go/home/follower/user_follower_screen.dart';
import 'package:to_let_go/home/following/user_following_screen.dart';
import 'package:to_let_go/util/strings.dart';

class UserAllData extends StatefulWidget {
  String? userName;
  String? uid;
  String? isComingFor;

  UserAllData(this.userName, this.uid, this.isComingFor, {Key? key}) : super(key: key);

  @override
  State<UserAllData> createState() => _UserAllDataState();
}

class _UserAllDataState extends State<UserAllData> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.isComingFor == Strings.following ? 0 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userName ?? ""),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Following"),
              Tab(text: "Followers"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserFollowingsScreen(widget.uid!),
            UserFollowersScreen(widget.uid!),
          ],
        ),
      ),
    );
  }
}
