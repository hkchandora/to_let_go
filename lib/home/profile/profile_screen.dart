import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/for_you/for_you_video_screen.dart';
import 'package:to_let_go/home/profile/account_setting.dart';
import 'package:to_let_go/home/profile/profile_controller.dart';
import 'package:to_let_go/home/user_all_data/user_all_data.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/preferences.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/util/utility.dart';
import 'package:to_let_go/widget/widget_common.dart';

class ProfileScreen extends StatefulWidget {

  String isComingFrom;
  String? uid;
  ProfileScreen( this.isComingFrom, this.uid, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Preferences preferences = Preferences();
  String? userId, userName, userProfileImage, facebookUrl, instagramUrl, whatsappUrl, twitterUrl, youtubeUrl;
  int? following, followers, posts;
  List? thumbnailUrlList = [];
  List videoUrlList = [];
  ProfileController profileController = Get.put(ProfileController());
  bool isFollow = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    Map<String, dynamic> userInfo = await profileController.getUserData(widget.uid!);
    userId = userInfo['uid'];
    userName = userInfo['name'] ?? "";
    userProfileImage = userInfo['image'] ?? "";
    facebookUrl = userInfo['facebook'] ?? "";
    instagramUrl = userInfo['instagram'] ?? "";
    whatsappUrl = userInfo['whatsapp'] ?? "";
    twitterUrl = userInfo['twitter'] ?? "";
    youtubeUrl = userInfo['youtube'] ?? "";
    thumbnailUrlList = await profileController.getUserAllVideoThumbnail(userInfo['uid']) ?? [];
    videoUrlList = await profileController.getUserAllVideoUrl(userInfo['uid']) ?? [];
    following = userInfo['following'] ?? 0;
    followers = userInfo['followers'] ?? 0;
    posts = thumbnailUrlList!.length;
    isFollow = userInfo['followersUidList'].toString().contains(FirebaseAuth.instance.currentUser!.uid);
    setState((){});
  }

  profileAppBar(){
    return AppBar(
      title: Text(userName ?? ""),
      leading: widget.isComingFrom != Strings.me ?
      IconButton(
        onPressed: () => Get.back(),
        icon: const ArrowToolbarBackwardNavigation(),
      ) : const SizedBox(),
      centerTitle: true,
      backgroundColor: colorBlack,
      actions: <Widget>[
        widget.isComingFrom == Strings.me ?
        PopupMenuButton<String>(
          onSelected: (value) async {
            switch (value) {
              case 'Settings':
                await Get.to(const AccountSetting());
                getData();
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
        ) :
        const SizedBox(),
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
                child: userProfileImage != null ? Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: () => _showDialog(context, userProfileImage!),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(userProfileImage!),
                        backgroundColor: colorBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        String imageUrl = await profileController.updateUserProfile();
                        setState(() {
                          userProfileImage = imageUrl;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 6, right: 8),
                        child: Icon(Icons.camera_alt_outlined, size: 34, color: colorRed),
                      ),
                    ),
                  ],
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
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(following.toString()),
                          const Text("Following"),
                        ],
                      ),
                      onTap: () => Get.to(UserAllData(userName, userId, Strings.following)),
                    ),
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(followers.toString()),
                          const Text("Followers"),
                        ],
                      ),
                      onTap: () => Get.to(UserAllData(userName, userId, Strings.followers)),
                    ),
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(posts.toString()),
                          const Text("Posts"),
                        ],
                      ),
                      onTap: () => null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      facebookUrl != null && facebookUrl!.isNotEmpty ? GestureDetector(
                        onTap: () => Utility.launchGivenUrl(facebookUrl!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(AssetImagePath.facebook, fit: BoxFit.fill, width: 50, height: 50),
                        ),
                      ) : const SizedBox(),
                      const SizedBox(width: 10),
                      instagramUrl != null && instagramUrl!.isNotEmpty ? GestureDetector(
                        onTap: () => Utility.launchGivenUrl("https://www.instagram.com/$instagramUrl"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(AssetImagePath.instagram, fit: BoxFit.fill, width: 50, height: 50),
                        ),
                      ) : const SizedBox(),
                      const SizedBox(width: 10),
                      whatsappUrl != null && whatsappUrl!.isNotEmpty ? GestureDetector(
                        onTap: () => Utility.launchGivenUrl("https://wa.me/+91$whatsappUrl"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(AssetImagePath.whatsapp, fit: BoxFit.fill, width: 50, height: 50),
                        ),
                      ) : const SizedBox(),
                      const SizedBox(width: 10),
                      twitterUrl != null && twitterUrl!.isNotEmpty ? GestureDetector(
                        onTap: () => Utility.launchGivenUrl(twitterUrl!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(AssetImagePath.twitter, fit: BoxFit.fill, width: 50, height: 50),
                        ),
                      ) : const SizedBox(),
                      const SizedBox(width: 10),
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
              SizedBox(height: widget.isComingFrom == Strings.me ? 20 : 0),
              widget.isComingFrom == Strings.me ? GestureDetector(
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
              ) : isFollow ? GestureDetector(
                onTap: () async {
                  await profileController.unfollowUser(FirebaseAuth.instance.currentUser!.uid, userId!);
                  setState(() {
                    isFollow = !isFollow;
                    followers = followers! - 1;
                  });
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
                    child: Text("Unfollow", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ) : GestureDetector(
                onTap: () async {
                  await profileController.followUser(FirebaseAuth.instance.currentUser!.uid, userId!);
                  setState(() {
                    isFollow = !isFollow;
                    followers = followers! + 1;
                  });
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
                    child: Text("Follow", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ]),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          const Divider(color: colorWhite, thickness: 1),
          thumbnailUrlList!.isEmpty ?
          const Expanded(
              child: Center(
                  child: Text("No Video! Please upload your first video"),
              ),
          ) :
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.5,
                mainAxisExtent: MediaQuery.of(context).size.height / 3.5,
              ),
              itemCount: thumbnailUrlList!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Get.to(() => ForYouVideoScreen(false, videoUrlList)),
                  child: Card(
                    color: colorWhite,
                    child: Image.network(thumbnailUrlList![index], fit: BoxFit.fill),
                  ),
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
                        MaterialButton(
                          child: const Text("No", style: TextStyle(color: colorWhite)),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        MaterialButton(
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


  void _showDialog(BuildContext context, String profileUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: ClipOval(
            child: CircleAvatar(backgroundImage: NetworkImage(profileUrl), radius: 150),
          )
        );
      },
    );
  }
}
