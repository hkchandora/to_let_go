import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_let_go/fcm/fcm_controller.dart';
import 'package:to_let_go/model/comment.dart';

class CommentController extends GetxController{


  Future<String> getNameAndFirebaseTokenByUserId(String uid) async {
    DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
        .collection("users").doc(uid).get();
    String name = (userDocumentSnapshot.data() as Map<String, dynamic>)["name"];
    String firebaseToken = (userDocumentSnapshot.data() as Map<String, dynamic>)["firebaseToken"];
    return "$name&&$firebaseToken";
  }


  addComment(String videoId, String username, String name, String profileImage, String firebaseToken, String commentText) async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      String commentId = DateTime.now().millisecondsSinceEpoch.toString();

      Comment comment = Comment(
        uid: currentUserId,
        username: username,
        name: name,
        commentText: commentText,
        profileImage: profileImage,
        dateTime: DateTime.now().toString(),
        commentId: commentId
      );

      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).collection("commentList").doc("$currentUserId&&$commentId").set(comment.toJson());

      //Send Notification
      FcmController fcmController = Get.put(FcmController());
      fcmController.sendFCM(
        firebaseToken,
        "Comment",
        "$username comment on your post.",
        {},
      );

    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }


  getAllVideoComment(String videoId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos')
        .doc(videoId)
        .collection("commentList")
        .get();
    List commentDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return commentDataList;
  }
}