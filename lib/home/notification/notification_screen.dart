import 'package:flutter/material.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: ListView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return index % 2 == 0 ? Card(
            margin: const EdgeInsets.fromLTRB(14, 10, 14, 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("User_name"),
                        Text("started following you"),
                      ],
                    ),
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
                  const CircleAvatar(
                    backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    child: Text("User_name liked your post."),
                  ),
                  const SizedBox(width: 24),
                  Image.asset(AssetImagePath.youtube, width: 40, height: 80, fit: BoxFit.fill),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
