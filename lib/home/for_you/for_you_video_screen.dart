import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/for_you/for_you_controller.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/style.dart';
import 'package:video_player/video_player.dart';

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
      // controller: ,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 90,
              child: Container(color: index % 2 == 0 ? Colors.red : colorWhite),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.access_time, size: 50),
                  Text("0"),
                  SizedBox(height: 16),
                  Icon(Icons.comment_outlined, size: 50),
                  Text("0"),
                  SizedBox(height: 16),
                  Icon(Icons.share, size: 50),
                  Text("0"),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

