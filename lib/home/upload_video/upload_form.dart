import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/upload_video/upload_controller.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/widget/input_text_widget.dart';
import 'package:video_player/video_player.dart';

class UploadForm extends StatefulWidget {

  final File videoFile;
  final String videoPath;

  const UploadForm({Key? key, required this.videoFile, required this.videoPath}) : super(key: key);

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  UploadController uploadController = Get.put(UploadController());
  VideoPlayerController? playerController;
  TextEditingController artistSongTextEditingController = TextEditingController();
  TextEditingController descriptionTagsTextEditingController = TextEditingController();

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
    playerController!.pause();
    playerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.3,
                child: VideoPlayer(playerController!),
              ),
              const SizedBox(height: 30),
              showProgressBar
                  ? const CircularProgressIndicator()
                  : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: InputTextWidget(
                      textEditingController: artistSongTextEditingController,
                      textInputType: TextInputType.emailAddress,
                      labelString: "Artist - Song",
                      iconData: Icons.music_video_sharp,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: InputTextWidget(
                      textEditingController: descriptionTagsTextEditingController,
                      textInputType: TextInputType.multiline,
                      labelString: "Description - Tags",
                      iconData: Icons.slideshow_sharp,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 54,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: InkWell(
                      onTap: (){

                        if(artistSongTextEditingController.text.isNotEmpty
                        && descriptionTagsTextEditingController.text.isNotEmpty){
                          uploadController.saveVideoInformationToFirestoreData(
                            artistSongTextEditingController.text.toString().trim(),
                            descriptionTagsTextEditingController.text.toString().trim(),
                            widget.videoPath,
                            context,
                          );
                          playerController!.pause();
                          setState(() {
                            showProgressBar = true;
                          });
                        }

                      },
                      child: const Center(child: Text("Upload Now", style: boldTextStyleBlack_20)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
