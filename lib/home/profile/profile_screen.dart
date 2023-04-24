import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/profile/account_setting.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/Preferences.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/utility.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Preferences preferences = Preferences();
  String? userName, facebookUrl, instagramUrl, whatsappUrl, twitterUrl, youtubeUrl;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userName = await preferences.getUserName();
    facebookUrl = await preferences.getUserFacebook();
    instagramUrl = await preferences.getUserInstagram();
    whatsappUrl = await preferences.getUserWhatsapp();
    twitterUrl = await preferences.getUserTwitter();
    youtubeUrl = await preferences.getUserYoutube();
    setState((){});
  }

  profileAppBar(){
    return AppBar(
      title: Text(userName ?? ""),
      centerTitle: true,
      backgroundColor: colorBlack,
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value){
            switch (value) {
              case 'Settings':
                Get.to(const AccountSetting());
                break;
              case 'Logout':
                Preferences().clearPreferences();
                FirebaseAuth.instance.signOut();
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Settings', 'Logout'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                backgroundColor: colorBlack,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("3"),
                      Text("Following"),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("4"),
                      Text("Followers"),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("100"),
                      Text("Likes"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  facebookUrl != null && facebookUrl!.isNotEmpty ? GestureDetector(
                    onTap: () => Utility.launchGivenUrl(facebookUrl!),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(AssetImagePath.facebook, fit: BoxFit.fill, width: 50, height: 50),
                    ),
                  ) : const SizedBox(),
                  instagramUrl != null && instagramUrl!.isNotEmpty ? GestureDetector(
                    onTap: () => Utility.launchGivenUrl("https://www.instagram.com/$instagramUrl"),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(AssetImagePath.instagram, fit: BoxFit.fill, width: 50, height: 50),
                    ),
                  ) : const SizedBox(),
                  whatsappUrl != null && whatsappUrl!.isNotEmpty ? GestureDetector(
                    onTap: () => Utility.launchGivenUrl("https://wa.me/+91$whatsappUrl"),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(AssetImagePath.whatsapp, fit: BoxFit.fill, width: 50, height: 50),
                    ),
                  ) : const SizedBox(),
                  twitterUrl != null && twitterUrl!.isNotEmpty ? GestureDetector(
                    onTap: () => Utility.launchGivenUrl(twitterUrl!),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(AssetImagePath.twitter, fit: BoxFit.fill, width: 50, height: 50),
                    ),
                  ) : const SizedBox(),
                  youtubeUrl != null && youtubeUrl!.isNotEmpty ? GestureDetector(
                    onTap: () => Utility.launchGivenUrl(youtubeUrl!),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(AssetImagePath.youtube, fit: BoxFit.fill, width: 50, height: 50),
                    ),
                  ) : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Preferences().clearPreferences();
                FirebaseAuth.instance.signOut();
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: colorDarkRed, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: const Center(
                  child: Text("Sign Out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: colorWhite, thickness: 1),
            // Expanded(
            //   child: GridView.count(
            //     crossAxisCount: 3,
            //     crossAxisSpacing: 4.0,
            //     mainAxisSpacing: 8.0,
            //     children: List.generate(3, (index) {
            //       return const Center(
            //         child: Text("text", style: TextStyle(color: colorWhite)),
            //       );
            //     }
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
