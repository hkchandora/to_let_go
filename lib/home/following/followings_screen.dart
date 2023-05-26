import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/following/following_controller.dart';
import 'package:to_let_go/util/style.dart';

class FollowingsScreen extends StatefulWidget {
  const FollowingsScreen({Key? key}) : super(key: key);

  @override
  State<FollowingsScreen> createState() => _FollowingsScreenState();
}

class _FollowingsScreenState extends State<FollowingsScreen> {

  FollowingController followingController = Get.put(FollowingController());
  List videoList = [];

  @override
  void initState() {
    getAllFollowingVideoData();
    super.initState();
  }

  getAllFollowingVideoData() async {
    videoList = await followingController.getAllFollowingVideoDataList();
  }

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
