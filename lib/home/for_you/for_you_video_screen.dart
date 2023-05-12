import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';
import 'package:video_player/video_player.dart';

class ForYouVideoScreen extends StatefulWidget {
  bool isComingFromDashboard = true;
  List videoList = [];
  ForYouVideoScreen(this.isComingFromDashboard, this.videoList, {Key? key}) : super(key: key);

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  List<VideoPlayerController>? playerControllerList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if(!widget.isComingFromDashboard) {
      for (var element in widget.videoList) {
        playerControllerList!.add(VideoPlayerController.network(element.toString()));
      }
      for(int i=0; i<widget.videoList.length; i++){
        // playerControllerList!.add(VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/to-let-go-4112b.appspot.com/o/All%20Videos%2F1682581057102?alt=media&token=9f5fd193-690a-48e1-a498-ab118471150f"));
        // playerControllerList![i] = VideoPlayerController.network(widget.videoList[i]);
        playerControllerList![i].initialize();
        playerControllerList![i].play();
        playerControllerList![i].setVolume(2);
        playerControllerList![i].setLooping(true);
      }
      setState(() {});
    }
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
    return Scaffold(
      body: widget.isComingFromDashboard ? const Center(
        child: Text(
          "For You video screen",
          style: extraBoldTextStyleWhite_18,
        ),
      ) : forYouScreenList(),
    );
  }

  forYouScreenList(){
    return ListView.builder(
      physics: const PageScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: widget.videoList.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: VideoPlayer(playerControllerList![index]),
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

