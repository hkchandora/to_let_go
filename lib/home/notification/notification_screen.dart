import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/notification/notification_controller.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/strings.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationController notificationController = Get.put(NotificationController());
  List allNotificationList = [];
  bool isApiCalling = true;

  @override
  void initState() {
    getAllNotification();
    super.initState();
  }

  getAllNotification() async {
    allNotificationList = await notificationController.getAllNotificationList();
    setState(() {
      isApiCalling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: isApiCalling ? const Center(child: Text(Strings.loading)) :
      ListView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: allNotificationList.length,
        itemBuilder: (context, index) {
          return allNotificationList[index]["notificationType"] == Strings.notificationTypeFollow ? Card(
            margin: const EdgeInsets.fromLTRB(14, 10, 14, 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(allNotificationList[index]["image"].toString()),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(allNotificationList[index]["notificationTitle"].toString()),
                  ),
                  const SizedBox(width: 24),
                  MaterialButton(
                    onPressed: (){},
                    color: colorDarkGray,
                    elevation: 0,
                    child: const Text("Follow"),
                  ),
                ],
              ),
            ),
          ) : Card(
            margin: const EdgeInsets.fromLTRB(14, 10, 14, 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(allNotificationList[index]["image"].toString()),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(allNotificationList[index]["notificationTitle"].toString()),
                  ),
                  // const SizedBox(width: 24),
                  // Image.asset(AssetImagePath.youtube, width: 40, height: 80, fit: BoxFit.fill),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
