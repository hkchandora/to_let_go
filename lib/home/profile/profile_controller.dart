import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  getAllVideoDataList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
    final allVideoData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allVideoData;
  }

  getAllVideoThumbnail() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
    List allVideoThumbnailData = querySnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['thumbnailUrl']).toList();
    return allVideoThumbnailData;
  }

  getUserAllVideoThumbnail(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').where("userId", isEqualTo: uid).get();
    List allVideoThumbnailData = querySnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['thumbnailUrl']).toList();
    return allVideoThumbnailData;
  }

  followUser(String followersUID, String followingUID) async{
    try{
      DocumentSnapshot followersDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(followersUID).get();
      int following = (followersDocumentSnapshot.data() as Map<String, dynamic>)["following"];
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).update({'following' : following + 1 });


      DocumentSnapshot followingDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(followingUID).get();
      int followers = (followingDocumentSnapshot.data() as Map<String, dynamic>)["followers"];
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).update({'followers' : followers + 1 });


    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }

  unfollowUser(String followersUID, String followingUID){

  }

}