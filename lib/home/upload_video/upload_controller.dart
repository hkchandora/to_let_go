import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController {

  compressVideoFile(String videoFilePah) async {
    final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePah, quality: VideoQuality.LowQuality);
    return compressedVideoFilePath!.file;
  }

  uploadCompressedVideoFileToFirebaseStorage(String videoId, String videoFilePath) async {
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
        .child("All Videos")
        .child(videoId)
        .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();
    return downloadUrlOfUploadedVideo;
  }

  getThumbnailImage(String videoFilePath) async {
    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);
    return thumbnailImage;
  }

  uploadThumbnailImageFileToFirebaseStorage(String videoId, String videoFilePath) async {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child("All Thumbnails")
        .child(videoId)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();
    return downloadUrlOfUploadedVideo;
  }

  saveVideoInformationToFirestoreData(String artistSongName, String descriptionTag, String videFilePath, BuildContext context) async {
    try {
      String videoId = DateTime.now().millisecondsSinceEpoch.toString();

    } catch (errorMsg){
       Get.snackbar("Video upload unsuccessful", "Error occurred, your video is not uploaded. Try again.");
    }
  }

}