import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:to_let_go/fcm/fcm_request_bean.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/model/notification_model.dart';
import 'package:to_let_go/util/base_dio.dart';
import 'package:to_let_go/util/constants.dart';

class FcmController extends GetxController{

  sendFCM(String receiverUserId, String firebaseToken,
      String title, String body, Map<String, dynamic> data,
      String notificationType) async {
    try {
      Dio dio = await BaseDio().getBaseDioForFCM();
      FcmRequestBean fcmRequestBean = FcmRequestBean(
        registrationIds: [firebaseToken],
        notification: Notification(
          title: title,
          body: body,
        ),
        data: data,
        apns: Apns(
          payload: Payload(
            aps: Aps(
              alert: Notification(
                title: title,
                body: body,
              ),
            ),
          ),
        ),
      );
      await dio.post(Constants.fcm, data: fcmRequestBean.toJson());

      debugPrint("currentUserId");
      debugPrint(currentUserId);
      debugPrint(receiverUserId);
      DocumentSnapshot currentUserDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(currentUserId).get();

      StoreNotification storeNotification = StoreNotification(
        name: (currentUserDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userName: (currentUserDocumentSnapshot.data() as Map<String, dynamic>)["username"],
        uid: (currentUserDocumentSnapshot.data() as Map<String, dynamic>)["uid"],
        image: (currentUserDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        notificationTitle: body,
        notificationType: notificationType,
        dateTime: DateTime.now().toString(),
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(receiverUserId).collection("notification").doc()
          .set(storeNotification.toJson());
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
  }
}