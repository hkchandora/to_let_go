import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_let_go/global.dart';
import 'package:video_player/video_player.dart';

class UploadForm extends StatefulWidget {

  final File videoFile;
  final String videoPath;

  UploadForm({required this.videoFile, required this.videoPath});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  VideoPlayerController? playerController;

  @override
  void initState() {
    super.initState();
    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: VideoPlayer(playerController!),
            ),
            const SizedBox(height: 30),
            showProgressBar  == true ? Container() : Column()
          ],
        ),
      ),
    );
  }
}
