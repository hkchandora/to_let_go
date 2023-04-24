import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/home_screen.dart';
import 'package:to_let_go/home/upload_video/video.dart';
import 'package:video_compress_ds/video_compress_ds.dart';

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

  saveVideoInformationToFirestoreData(String artistSongName, String descriptionTag, String videoFilePath, BuildContext context) async {
    try {
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      String videoId = DateTime.now().millisecondsSinceEpoch.toString();

      //1. Upload video to storage
      String videoDownloadUrl = await uploadCompressedVideoFileToFirebaseStorage(videoId, videoFilePath);

      //2. Upload thumbnail to storage
      String thumbnailDownloadUrl = await uploadThumbnailImageFileToFirebaseStorage(videoId, videoFilePath);

      //3. Save overall video info to firestore database
      Video videoObject = Video(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userProfileImage: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        videoID: videoId,
        totalComments: 0,
        totalShares: 0,
        likeList: [],
        artistSongName: artistSongName,
        descriptionTags: descriptionTag,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch
      );

      await FirebaseFirestore.instance.collection("videos").doc(videoId).set(videoObject.toJson());

      showProgressBar = false;
      Get.to(const HomeScreen());
      Get.snackbar("New Video", "You have successfully upload your new video.");
    } catch (errorMsg){
       Get.snackbar("Video upload unsuccessful", "Error occurred, your video is not uploaded. Try again.");
    }
  }

}