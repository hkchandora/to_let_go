import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:to_let_go/fcm/fcm_controller.dart';
import 'package:to_let_go/fcm/fcm_request_bean.dart';
import 'package:to_let_go/util/base_dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_let_go/authentication/authentication_controller.dart';
import 'package:to_let_go/model/user.dart';
import 'package:to_let_go/util/constants.dart';
import 'package:to_let_go/util/preferences.dart';

class ProfileController extends GetxController {

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

  Future<Map<String, dynamic>> getUserData(String uid) async {
    DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
        .collection("users").doc(uid).get();
    return userDocumentSnapshot.data() as Map<String, dynamic>;
  }


  getUserFollowersList(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .collection("followersList")
        .get();
    List followersUserDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return followersUserDataList;
  }

  getUserFollowingList(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .collection("followingList")
        .get();
    List followingUserDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return followingUserDataList;
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
        username: (followingDocumentSnapshot.data() as Map<String, dynamic>)["username"],
        email: (followingDocumentSnapshot.data() as Map<String, dynamic>)["email"],
        image: (followingDocumentSnapshot.data() as Map<String, dynamic>)["image"],
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).collection("followingList").doc("$followingUID&&$followersUID")
          .set(childUserInfoFollowing.toJson());

      //set Followers collect user info
      ChildUserInfo childUserInfoFollowers = ChildUserInfo(
          uid: followersUID,
          name: (followersDocumentSnapshot.data() as Map<String, dynamic>)["name"],
          username: (followingDocumentSnapshot.data() as Map<String, dynamic>)["username"],
          email: (followersDocumentSnapshot.data() as Map<String, dynamic>)["email"],
          image: (followersDocumentSnapshot.data() as Map<String, dynamic>)["image"]
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).collection("followersList").doc("$followersUID&&$followingUID")
          .set(childUserInfoFollowers.toJson());

      //Set followers and following uid list
      await FirebaseFirestore.instance.collection("users")
          .doc(followersUID).update({"followingUidList": FieldValue.arrayUnion([followingUID])});
      await FirebaseFirestore.instance.collection("users")
          .doc(followingUID).update({"followersUidList": FieldValue.arrayUnion([followersUID])});


      //Send Notification
      FcmController fcmController = Get.put(FcmController());
      fcmController.sendFCM(
        (followingDocumentSnapshot.data() as Map<String, dynamic>)["firebaseToken"],
        "Follow",
        "${(followingDocumentSnapshot.data() as Map<String, dynamic>)["name"]} (@${(followingDocumentSnapshot.data() as Map<String, dynamic>)["username"]}) has started to follow you.",
        {},
      );
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

      //Send Notification
      FcmController fcmController = Get.put(FcmController());
      fcmController.sendFCM(
        (followingDocumentSnapshot.data() as Map<String, dynamic>)["firebaseToken"],
        "Unfollow",
        "${(followingDocumentSnapshot.data() as Map<String, dynamic>)["name"]} (@${(followingDocumentSnapshot.data() as Map<String, dynamic>)["username"]}) unfollow you.",
        {},
      );

      Preferences preferences = Preferences();
      preferences.setUserFollowing(following - 1);
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }


  Future<String> updateUserProfile() async {
    var authenticationController = AuthenticationController.instanceAuth;
    File? profileImage;
    profileImage = await authenticationController.chooseImageFromGallery();
    String imageDownloadUrl = await authenticationController.uploadImageToStorage(profileImage);
    await FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid).update({'image' : imageDownloadUrl});

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('videos')
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List allUsersVideoList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(var element in allUsersVideoList){
      if(element['userId'] == FirebaseAuth.instance.currentUser!.uid){
        await FirebaseFirestore.instance.collection("videos")
            .doc(element['videoID']).update({'userImage' : imageDownloadUrl});
      }
    }

    return imageDownloadUrl;
  }
}