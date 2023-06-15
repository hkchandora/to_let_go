import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_let_go/fcm/fcm_controller.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/comment/comment_controller.dart';
import 'package:to_let_go/model/user.dart';

class ForYouController  extends GetxController {

  getAllVideoDataList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
    final allVideoData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allVideoData.reversed.toList();
  }

  getAllVideoThumbnail() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
    List allVideoThumbnailData = querySnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['thumbnailUrl']).toList();
    return allVideoThumbnailData;
  }

  likeVideo(String videoId, String userId, String userName) async{
    try {
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(currentUserId).get();

      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).update({"likeUidList": FieldValue.arrayUnion([currentUserId])});

      ChildUserInfo childUserInfoFollowing = ChildUserInfo(
        uid: currentUserId,
        name: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        username: (userDocumentSnapshot.data() as Map<String, dynamic>)["username"],
        email: (userDocumentSnapshot.data() as Map<String, dynamic>)["email"],
        image: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
      );

      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).collection("likeList").doc("$currentUserId&&$videoId").set(childUserInfoFollowing.toJson());

      if(currentUserId != userId){
        CommentController commentController = Get.put(CommentController());
        String firebaseToken = await commentController.getFirebaseTokenByUserId(userId);
        //Send Notification
        FcmController fcmController = Get.put(FcmController());
        await fcmController.sendFCM(
          firebaseToken,
          "Like Post",
          "${(userDocumentSnapshot.data() as Map<String, dynamic>)["username"]} like your post.",
          {},
        );
      }
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }

  unLikeVideo(String videoId, String userId, String userName) async{
    try{
      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).collection("likeList").doc("$currentUserId&&$videoId").delete();
      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).update({"likeUidList": FieldValue.arrayRemove([currentUserId])});


      if(currentUserId != userId){
        CommentController commentController = Get.put(CommentController());
        String firebaseToken = await commentController.getFirebaseTokenByUserId(userId);
        //Send Notification
        FcmController fcmController = Get.put(FcmController());
        await fcmController.sendFCM(
          firebaseToken,
          "Like Post",
          "$userName like your post.",
          {},
        );
      }
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }
}