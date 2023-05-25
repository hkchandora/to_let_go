import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/profile/profile_controller.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:to_let_go/util/style.dart';

import '../profile/profile_screen.dart';

//ignore: must_be_immutable
class UserFollowersScreen extends StatefulWidget {
  String? uid;
  UserFollowersScreen(this.uid, {Key? key}) : super(key: key);

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  ProfileController profileController = Get.put(ProfileController());
  List followersUserList = [];

  @override
  void initState() {
    getFollowersData();
    super.initState();
  }

  getFollowersData() async {
    followersUserList = await profileController.getUserFollowersList(widget.uid!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: followersUserList.isEmpty ?
      const Center(child: Text("No Followers")) :
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: followersUserList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.to(() => ProfileScreen(Strings.followers, followersUserList[index]['uid'])),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: const BoxDecoration(
                color: colorBlack,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(followersUserList[index]['image']),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(followersUserList[index]['name'], style: boldTextStyleWhite_16),
                        Text(followersUserList[index]['email'], style: extraBoldTextStyleDarkGray_14.copyWith(color: colorLightWhite70))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
