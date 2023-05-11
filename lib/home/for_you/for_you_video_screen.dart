import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';
import 'package:video_player/video_player.dart';

class ForYouVideoScreen extends StatefulWidget {
  bool isComingFromDashboard = true;
  ForYouVideoScreen(this.isComingFromDashboard, {Key? key}) : super(key: key);

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  VideoPlayerController? playerController;
  
  
  @override
  void initState() {
    super.initState();
    setState(() {
      playerController = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/to-let-go-4112b.appspot.com/o/All%20Videos%2F1682581057102?alt=media&token=9f5fd193-690a-48e1-a498-ab118471150f");
    });
    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    playerController!.dispose();
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
      physics: PageScrollPhysics(),
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return forYouScreen();
      },
    );
  }

  forYouScreen(){
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: VideoPlayer(playerController!),
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
  }
}

