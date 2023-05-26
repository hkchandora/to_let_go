import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/following/following_controller.dart';
import 'package:to_let_go/home/profile/profile_screen.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/strings.dart';
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: allFollowingVideoList(),
      ),
    );
  }

  allFollowingVideoList(){
    return videoList.isEmpty ? const Center(
        child: Text(
          "No Data",
          style: extraBoldTextStyleWhite_18,
        ),
    ) : ListView.builder(
      physics: const PageScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 86,
              child: Container(color: index % 2 == 0 ? colorBlue : colorDarkRed),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => ProfileScreen(
                              videoList[index]['userId'].toString() == FirebaseAuth.instance.currentUser!.uid ? Strings.me : Strings.foYou,
                              videoList[index]['userId'].toString())),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(videoList[index]['userImage'].toString()),
                                radius: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(videoList[index]['userName'].toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(videoList[index]['descriptionTags'].toString()),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.music_note, size: 20),
                            const SizedBox(width: 4),
                            Text(videoList[index]['artistSongName'].toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time, size: 30),
                      Text((videoList[index]['totalComments'] ?? "0").toString()),
                      const SizedBox(height: 16),
                      const Icon(Icons.comment_outlined, size: 30),
                      Text((videoList[index]['totalLikes'] ?? "0").toString()),
                      const SizedBox(height: 16),
                      const Icon(Icons.share, size: 30),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
