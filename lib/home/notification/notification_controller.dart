import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_let_go/global.dart';

class NotificationController extends GetxController {

  getAllNotificationList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users')
        .doc(currentUserId)
        .collection("notification").get();
    final allNotification = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allNotification.reversed.toList();
  }
}