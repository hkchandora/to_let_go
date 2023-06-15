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

  Future<String> getFirebaseTokenByUserId(String uid) async {
    DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
        .collection("users").doc(uid).get();
    String firebaseToken = (userDocumentSnapshot.data() as Map<String, dynamic>)["firebaseToken"];
    return firebaseToken;
  }


  addComment(String videoUserId, String videoId, String username, String name, String profileImage, String firebaseToken, String commentText) async {
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
        commentId: commentId,
        commentLikeUidList: []
      );

      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).collection("commentList").doc("$currentUserId&&$commentId").set(comment.toJson());

      //Update count of Comments
      DocumentSnapshot videoDocumentSnapshot = await FirebaseFirestore.instance
          .collection("videos").doc(videoId).get();
      int comments = (videoDocumentSnapshot.data() as Map<String, dynamic>)["totalComments"];
      await FirebaseFirestore.instance.collection("videos")
          .doc(videoId).update({'totalComments' : comments + 1});

      //Send Notification
      FcmController fcmController = Get.put(FcmController());
      await fcmController.sendFCM(
        videoUserId,
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


  likeVideoComment(String videoId, String commentUserId, String commentId, String currentUserName) async{
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      String firebaseToken = await getFirebaseTokenByUserId(commentUserId);
      await FirebaseFirestore.instance
          .collection("videos").doc(videoId).collection("commentList")
          .doc("$commentUserId&&$commentId")
          .update({"commentLikeUidList": FieldValue.arrayUnion([currentUserId])});

    //Send Notification
      FcmController fcmController = Get.put(FcmController());
      await fcmController.sendFCM(
        commentUserId,
        firebaseToken,
        "Comment Like",
        "$currentUserName like your comment.",
        {},
      );
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }

  unLikeVideoComment(String videoId, String commentUserId, String commentId, String currentUserName) async{
    try{
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      String firebaseToken = await getFirebaseTokenByUserId(commentUserId);
      await FirebaseFirestore.instance
          .collection("videos").doc(videoId).collection("commentList")
          .doc("$commentUserId&&$commentId")
          .update({"commentLikeUidList": FieldValue.arrayRemove([currentUserId])});

      //Send Notification
      FcmController fcmController = Get.put(FcmController());
      await fcmController.sendFCM(
        commentUserId,
        firebaseToken,
        "Comment Unlike",
        "$currentUserName unlike your comment.",
        {},
      );
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }

}