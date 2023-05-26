import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/for_you/for_you_controller.dart';
import 'package:to_let_go/home/profile/profile_screen.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:video_player/video_player.dart';

//ignore: must_be_immutable
class ForYouVideoScreen extends StatefulWidget {
  bool isComingFromDashboard = true;
  ForYouVideoScreen(this.isComingFromDashboard, {Key? key}) : super(key: key);

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  List<VideoPlayerController>? playerControllerList = [];
  ForYouController forYouController = Get.put(ForYouController());
  int currentIndex = 0;
  List videoList = [];

  @override
  void initState() {
    super.initState();
    getAllVideoListData();
  }

  getAllVideoListData() async {
    videoList = await forYouController.getAllVideoDataList();
    for (var element in videoList) {
      playerControllerList!.add(VideoPlayerController.network(element['videoUrl'].toString()));
    }
    for(int i=0; i<videoList.length; i++){
      // playerControllerList![i].initialize();
      // playerControllerList![i].play();
      // playerControllerList![i].setVolume(2);
      // playerControllerList![i].setLooping(true);
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if(!widget.isComingFromDashboard) {
      playerControllerList![currentIndex].dispose();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: forYouScreenList(),
      ),
    );
  }

  forYouScreenList(){
    return ListView.builder(
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
                      GestureDetector(
                        onTap: () async {
                          if(videoList[index]['likeUidList'].toString().contains(currentUserId)){
                            await forYouController.unLikeVideo(videoList[index]['videoID']);
                          } else {
                            await forYouController.likeVideo(videoList[index]['videoID']);
                          }
                        },
                        child: Image.asset(videoList[index]['likeUidList'].toString().contains(currentUserId)
                            ? AssetImagePath.like : AssetImagePath.unlike, height: 34, width: 34, fit: BoxFit.fill,
                          color: videoList[index]['likeUidList'].toString().contains(currentUserId) ? colorDarkRed: colorBlack),
                      ),
                      Text(List.from(videoList[index]['likeUidList']).length.toString()),
                      const SizedBox(height: 16),
                      Image.asset(AssetImagePath.comment, height: 34, width: 34, fit: BoxFit.fill, color: colorBlack),
                      Text((videoList[index]['totalComments'] ?? "0").toString()),
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

