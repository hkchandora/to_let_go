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

}