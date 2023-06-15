import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/profile/edit_profile_screen.dart';
import 'package:to_let_go/home/profile/profile_controller.dart';
import 'package:to_let_go/home/user_all_data/user_all_data.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/preferences.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/util/utility.dart';
import 'package:to_let_go/widget/loading_dialog_widget.dart';
import 'package:to_let_go/widget/widget_common.dart';
import 'package:url_launcher/url_launcher.dart';

//ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {

  String isComingFrom;
  String? uid;
  ProfileScreen( this.isComingFrom, this.uid, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Preferences preferences = Preferences();
  String? userId, userName, userEmail, userBio, name, link, gender,
      userProfileImage, facebookUrl, instagramUrl, whatsappUrl, twitterUrl, youtubeUrl;
  int? following, followers, posts;
  List? thumbnailUrlList = [];
  List videoUrlList = [];
  ProfileController profileController = Get.put(ProfileController());
  ScrollController scrollController = ScrollController();
  bool isFollow = false;
  bool isApiCalling = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    Map<String, dynamic> userInfo = await profileController.getUserData(widget.uid!);
    userId = userInfo['uid'];
    userName = userInfo['username'] ?? "";
    name = userInfo['name'] ?? "";
    link = userInfo['link'] ?? "";
    gender = userInfo['gender'] ?? "";
    userBio = userInfo['bio'] ?? "";
    userEmail = userInfo['email'] ?? "";
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
    setState((){
      isApiCalling = false;
    });
  }

  profileAppBar(){
    return AppBar(
      elevation: 0,
      title: Text(userName ?? "", style: regularTextStyle_18),
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
              case 'Logout':
                logoutConfirmDialog("Logout", "Do you want to log out?");
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Logout'}.map((String choice) {
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
      body: isApiCalling ? const Center(child: Text("Loading...")) : schemeSelectionBody(),
    );
  }

  Widget schemeSelectionBody() {
    return NestedScrollView(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userProfileImage != null ? GestureDetector(
                          onTap: () => _showDialog(context, userProfileImage!),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.12,
                            backgroundImage: NetworkImage(userProfileImage!),
                            backgroundColor: colorBlack,
                          ),
                        ) : CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.12,
                          backgroundImage: const AssetImage(AssetImagePath.profileAvatar),
                          backgroundColor: colorBlack,
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(following.toString(), style: semiBoldTextStyle_18),
                                    const Text("Following", style: mediumTextStyle_14),
                                  ],
                                ),
                                onTap: () => Get.to(UserAllData(userName, userId, Strings.following)),
                              ),
                              GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(followers.toString(), style: semiBoldTextStyle_18),
                                    const Text("Followers", style: mediumTextStyle_14),
                                  ],
                                ),
                                onTap: () => Get.to(UserAllData(userName, userId, Strings.followers)),
                              ),
                              GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(posts.toString(), style: semiBoldTextStyle_18),
                                    const Text("Posts", style: mediumTextStyle_14),
                                  ],
                                ),
                                onTap: () {
                                  scrollController.animateTo(500,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(name ?? "", style: boldTextStyle_14),
                    Text(userBio ?? "", style: mediumTextStyle_14),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: link,
                            style: const TextStyle(color: colorBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Utility.launchGivenUrl(link!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 30),
              // Center(
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         facebookUrl != null && facebookUrl!.isNotEmpty ? GestureDetector(
              //           onTap: () => Utility.launchGivenUrl(facebookUrl!),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(14),
              //             child: Image.asset(AssetImagePath.facebook, fit: BoxFit.fill, width: 50, height: 50),
              //           ),
              //         ) : const SizedBox(),
              //         const SizedBox(width: 10),
              //         instagramUrl != null && instagramUrl!.isNotEmpty ? GestureDetector(
              //           onTap: () => Utility.launchGivenUrl("https://www.instagram.com/$instagramUrl"),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(14),
              //             child: Image.asset(AssetImagePath.instagram, fit: BoxFit.fill, width: 50, height: 50),
              //           ),
              //         ) : const SizedBox(),
              //         const SizedBox(width: 10),
              //         whatsappUrl != null && whatsappUrl!.isNotEmpty ? GestureDetector(
              //           onTap: () => Utility.launchGivenUrl("https://wa.me/+91$whatsappUrl"),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(14),
              //             child: Image.asset(AssetImagePath.whatsapp, fit: BoxFit.fill, width: 50, height: 50),
              //           ),
              //         ) : const SizedBox(),
              //         const SizedBox(width: 10),
              //         twitterUrl != null && twitterUrl!.isNotEmpty ? GestureDetector(
              //           onTap: () => Utility.launchGivenUrl(twitterUrl!),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(14),
              //             child: Image.asset(AssetImagePath.twitter, fit: BoxFit.fill, width: 50, height: 50),
              //           ),
              //         ) : const SizedBox(),
              //         const SizedBox(width: 10),
              //         youtubeUrl != null && youtubeUrl!.isNotEmpty ? GestureDetector(
              //           onTap: () => Utility.launchGivenUrl(youtubeUrl!),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(14),
              //             child: Image.asset(AssetImagePath.youtube, fit: BoxFit.fill, width: 50, height: 50),
              //           ),
              //         ) : const SizedBox(),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: widget.isComingFrom == Strings.me ? 20 : 0),
              widget.isComingFrom == Strings.me ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await Get.to(EditProfileScreen(
                              userProfileImage ?? "",
                              userName ?? "",
                              name ?? "",
                              userBio ?? "",
                              link ?? "",
                              gender ?? ""));
                          getData();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorDarkRed, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                          ),
                          child: const Center(
                            child: Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorWhite)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String subject = "To Let Go";
                          String body = "Hello Himanshu, \n\nMy Self $userName.\n\n";
                          launchUrl(Uri.parse("mailto:$userEmail?subject=$subject&body=$body"));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorDarkRed, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                          ),
                          child: const Center(
                            child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorWhite)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ) : isFollow ? GestureDetector(
                onTap: () async {
                  LoadingDialogWidget.showDialogLoading(context, Strings.pleaseWait);
                  await profileController.unfollowUser(FirebaseAuth.instance.currentUser!.uid, userId!);
                  setState(() {
                    isFollow = !isFollow;
                    followers = followers! - 1;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorDarkRed, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: const Center(
                    child: Text("Unfollow", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorWhite)),
                  ),
                ),
              ) : GestureDetector(
                onTap: () async {
                  LoadingDialogWidget.showDialogLoading(context, Strings.pleaseWait);
                  await profileController.followUser(FirebaseAuth.instance.currentUser!.uid, userId!);
                  setState(() {
                    isFollow = !isFollow;
                    followers = followers! + 1;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorDarkRed, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: const Center(
                    child: Text("Follow", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorWhite)),
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
                return Card(
                  color: colorWhite,
                  child: Image.network(thumbnailUrlList![index], fit: BoxFit.fill),
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
          backgroundColor: colorTransparent,
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
          backgroundColor: colorTransparent,
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
