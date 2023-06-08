import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SplashController extends GetxController {


  getAppUpdateData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('appUpdate').get();
    final allAppUpdateDetailsList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allAppUpdateDetailsList;
  }

  Future<bool> canUpdateVersion(storeVersion, localVersion) async {
    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();
    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i]) {
        return true;
      }
      if (local[i] > store[i]) {
        return false;
      }
    }
    return false;
  }

}