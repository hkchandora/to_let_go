import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FollowingController  extends GetxController {

  getAllFollowingVideoDataList() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).get();
    List allFollowingList = [];
    allFollowingList = (userSnapshot.data() as Map<String, dynamic>)["followingUidList"];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
    List allVideoData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List followingVideoList = [];
    for(int i = 0; i < allVideoData.length; i++){
      if(allFollowingList.contains(allVideoData[i]["userId"])){
        followingVideoList.add(allVideoData[i]);
      }
    }
    return followingVideoList.reversed.toList();
  }
}