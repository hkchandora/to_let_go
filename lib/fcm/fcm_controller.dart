import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:to_let_go/fcm/fcm_request_bean.dart';
import 'package:to_let_go/util/base_dio.dart';
import 'package:to_let_go/util/constants.dart';

class FcmController extends GetxController{

  sendFCM(String firebaseToken, String title, String body, Map<String, dynamic> data) async {
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
  }
}