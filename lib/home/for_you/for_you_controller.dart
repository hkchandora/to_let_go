import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ForYouController  extends GetxController {

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
}