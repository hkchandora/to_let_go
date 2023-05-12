import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/profile/profile_controller.dart';
import 'package:to_let_go/home/profile/profile_screen.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:to_let_go/util/style.dart';

class UserFollowingsScreen extends StatefulWidget {
  String? uid;
  UserFollowingsScreen(this.uid, {Key? key}) : super(key: key);

  @override
  State<UserFollowingsScreen> createState() => _UserFollowingsScreenState();
}

class _UserFollowingsScreenState extends State<UserFollowingsScreen> {

  ProfileController profileController = Get.put(ProfileController());
  List followingUserList = [];

  @override
  void initState() {
    getFollowingData();
    super.initState();
  }

  getFollowingData() async {
    followingUserList = await profileController.getUserFollowingList(widget.uid!);
    print("followingUserList");
    print(followingUserList);
    print(followingUserList.length);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  followingUserList.isEmpty ?
      const Center(child: Text("No Following")) :
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: followingUserList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.to(() => ProfileScreen(Strings.following, followingUserList[index]['uid'])),
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
                      backgroundImage: NetworkImage(followingUserList[index]['image']),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(followingUserList[index]['name'], style: boldTextStyleWhite_16),
                        Text(followingUserList[index]['email'], style: extraBoldTextStyleDarkGray_14.copyWith(color: colorLightWhite70))
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
