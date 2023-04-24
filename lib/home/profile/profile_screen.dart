import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/profile/account_setting.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/Preferences.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/util/utility.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Preferences preferences = Preferences();
  String? userName, userProfileImage, facebookUrl, instagramUrl, whatsappUrl, twitterUrl, youtubeUrl;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userName = await preferences.getUserName();
    userProfileImage = await preferences.getUserprofileImageUrl();
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
                logoutConfirmDialog("Logout", "Do you want to log out?");
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
      body: schemeSelectionBody(),
    );
  }

  Widget schemeSelectionBody() {
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Center(
                child: userProfileImage != null ? CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(userProfileImage!),
                  backgroundColor: colorBlack,
                ) : const CircleAvatar(
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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
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
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => logoutConfirmDialog("Sign Out", "Do you want to sign out?"),
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
            ]),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          const Divider(color: colorWhite, thickness: 1),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2, mainAxisExtent: 250
              ),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.white,
                  child: SizedBox(height: 500,child: Text('$index')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  logoutConfirmDialog(String title, String txt) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: colorLightGray,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: extraBoldTextStyleWhite_18),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(txt, style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: const Text("No", style: TextStyle(color: colorWhite)),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        FlatButton(
                          child: const Text("Yes", style: TextStyle(color: colorWhite)),
                          onPressed: () {
                            Get.back();
                            Preferences().clearPreferences();
                            FirebaseAuth.instance.signOut();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
