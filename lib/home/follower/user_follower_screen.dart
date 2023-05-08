import 'package:flutter/material.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/style.dart';

class UserFollowersScreen extends StatefulWidget {
  const UserFollowersScreen({Key? key}) : super(key: key);

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: const BoxDecoration(
                color: colorBlack,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name", style: boldTextStyleWhite_16),
                        Text("Email", style: extraBoldTextStyleDarkGray_14.copyWith(color: colorLightWhite70))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
