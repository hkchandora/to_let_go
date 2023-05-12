import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_let_go/model/user.dart';
import 'package:to_let_go/util/preferences.dart';

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

  getUserAllVideoUrl(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').where("userId", isEqualTo: uid).get();
    List allVideoThumbnailData = querySnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['videoUrl']).toList();
    return allVideoThumbnailData;
  }

  followUser(String followersUID, String followingUID) async{
    try{
      //Get User's info
      DocumentSnapshot followersDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(followersUID).get();
      DocumentSnapshot followingDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(followingUID).get();

      //Get count of followers and following
      int following = (followersDocumentSnapshot.data() as Map<String, dynamic>)["following"];
      int followers = (followingDocumentSnapshot.data() as Map<String, dynamic>)["followers"];

      //Set count of followers and following
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).update({'following' : following + 1});
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).update({'followers' : followers + 1 });

      //set Following collect user info
      ChildUserInfo childUserInfoFollowing = ChildUserInfo(
        uid: followingUID,
        name: (followingDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        email: (followingDocumentSnapshot.data() as Map<String, dynamic>)["email"],
        image: (followingDocumentSnapshot.data() as Map<String, dynamic>)["image"]
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).collection("followingList").doc("$followingUID&&$followersUID").set(childUserInfoFollowing.toJson());

      //set Followers collect user info
      ChildUserInfo childUserInfoFollowers = ChildUserInfo(
          uid: followersUID,
          name: (followersDocumentSnapshot.data() as Map<String, dynamic>)["name"],
          email: (followersDocumentSnapshot.data() as Map<String, dynamic>)["email"],
          image: (followersDocumentSnapshot.data() as Map<String, dynamic>)["image"]
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).collection("followersList").doc("$followersUID&&$followingUID").set(childUserInfoFollowers.toJson());

      //Set followers and following uid list
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).update({"followingUidList": FieldValue.arrayUnion([followingUID])});
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).update({"followersUidList": FieldValue.arrayUnion([followersUID])});

      Preferences preferences = Preferences();
      preferences.setUserFollowing(following + 1);
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }

  unfollowUser(String followersUID, String followingUID) async {
    try{
      //Get User's info
      DocumentSnapshot followersDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(followersUID).get();
      DocumentSnapshot followingDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(followingUID).get();

      //Get count of followers and following
      int following = (followersDocumentSnapshot.data() as Map<String, dynamic>)["following"];
      int followers = (followingDocumentSnapshot.data() as Map<String, dynamic>)["followers"];

      //Set count of followers and following
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).update({'following' : following - 1});
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).update({'followers' : followers - 1 });

      //set Following collect user info
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).collection("followingList").doc("$followingUID&&$followersUID").delete();

      //set Followers collect user info
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).collection("followersList").doc("$followersUID&&$followingUID").delete();

      //Set followers and following uid list
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).update({"followingUidList": FieldValue.arrayRemove([followingUID])});
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).update({"followersUidList": FieldValue.arrayRemove([followersUID])});

      Preferences preferences = Preferences();
      preferences.setUserFollowing(following - 1);
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }

}