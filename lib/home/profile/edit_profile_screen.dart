import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/authentication/authentication_controller.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/profile/profile_controller.dart';
import 'package:to_let_go/util/preferences.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/widget/widget_common.dart';

//ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  String profile, username, name, bio, link, gender;
  EditProfileScreen(this.profile, this.username, this.name, this.bio, this.link, this.gender, {Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController facebookTextEditingController = TextEditingController();
  TextEditingController instagramTextEditingController = TextEditingController();
  TextEditingController whatsappTextEditingController = TextEditingController();
  TextEditingController twitterTextEditingController = TextEditingController();
  TextEditingController youtubeTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  TextEditingController linkTextEditingController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;
  Preferences preferences = Preferences();
  String? profileImage;
  String gender = "";
  String theme = "";

  @override
  void initState() {
    getDataFromPreference();
    super.initState();
  }

  getDataFromPreference() async {
  /*  String userProfileImage = await preferences.getUserprofileImageUrl();
    String userFacebook = await preferences.getUserFacebook();
    String userInstagram = await preferences.getUserInstagram();
    String userWhatsapp = await preferences.getUserWhatsapp();
    String userTwitter = await preferences.getUserTwitter();
    String userYoutube = await preferences.getUserYoutube();*/
    bool isDark = await preferences.getIsDarkTheme();
    setState(() {
    /*  profileImage = userProfileImage;
      facebookTextEditingController.text = userFacebook;
      instagramTextEditingController.text = userInstagram;
      whatsappTextEditingController.text = userWhatsapp;
      twitterTextEditingController.text = userTwitter;
      youtubeTextEditingController.text = userYoutube;*/
      profileImage = widget.profile;
      usernameTextEditingController.text = widget.username;
      nameTextEditingController.text = widget.name;
      bioTextEditingController.text = widget.bio;
      linkTextEditingController.text = widget.link;
      gender = widget.gender;
      theme = isDark ? "Dark" : "Light";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile",  style: TextStyle(color: colorWhite)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: colorBlack,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: const CrossBackwardNavigation(),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,6,20,20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.12,
                  backgroundImage: NetworkImage(profileImage!),
                  backgroundColor: colorBlack,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () async {
                    ProfileController profileController = Get.put(ProfileController());
                    String userImage = await profileController.updateUserProfile();
                    setState(() {
                      profileImage = userImage;
                    });
                  },
                  child: const Text("Change Profile",
                    style: TextStyle(color: colorBlue),
                  ),
                ),
                const SizedBox(height: 20),



                /* const Text("Upload Your Social Links :-", style: regularTextStyleWhite_24),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: facebookTextEditingController,
                  textInputType: TextInputType.url,
                  labelString: "Facebook",
                  assetReference: AssetImagePath.facebook,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: instagramTextEditingController,
                  textInputType: TextInputType.text,
                  labelString: "Instagram/UserName",
                  assetReference: AssetImagePath.instagram,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: whatsappTextEditingController,
                  textInputType: TextInputType.phone,
                  labelString: "Whatsapp/Phone Number",
                  assetReference: AssetImagePath.whatsapp,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: twitterTextEditingController,
                  textInputType: TextInputType.url,
                  labelString: "Twitter",
                  assetReference: AssetImagePath.twitter,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: youtubeTextEditingController,
                  textInputType: TextInputType.url,
                  labelString: "Youtube",
                  assetReference: AssetImagePath.youtube,
                  isObscure: false,
                ),
                const SizedBox(height: 30),*/

                Column(
                  children: [
                    const Divider(color: colorWhite,thickness: 0.1,height: 0.1),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Username    ", style: TextStyle(color: colorWhite)),
                        Expanded(
                          child: TextField(
                            controller: usernameTextEditingController,
                            style: const TextStyle(color: colorWhite),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacerLine(),
                    Row(
                      children: [
                        const Text("Name           ", style: TextStyle(color: colorWhite),),
                        Expanded(
                          child: TextField(
                            controller: nameTextEditingController,
                            style: const TextStyle(color: colorWhite),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacerLine(),
                    Row(
                      children: [
                        const Text("Bio                ", style: TextStyle(color: colorWhite),),
                        Expanded(
                          child: TextField(
                            controller: bioTextEditingController,
                            style: const TextStyle(color: colorWhite),
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 2,
                            decoration: const InputDecoration(
                              hintText: 'Bio',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacerLine(),
                    Row(
                      children: [
                        const Text("Link              ", style: TextStyle(color: colorWhite),),
                        Expanded(
                          child: TextField(
                            controller: linkTextEditingController,
                            style: const TextStyle(color: colorWhite),
                            keyboardType: TextInputType.url,
                            decoration: const InputDecoration(
                              hintText: 'Link',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacerLine(),
                    Row(
                      children: [
                        const Text("Gender       ", style: TextStyle(color: colorWhite)),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Radio<String>(
                                        value: "Male",
                                        toggleable: true,
                                        activeColor: colorWhite,
                                        fillColor: MaterialStateColor.resolveWith((states) => colorWhite),
                                        groupValue: gender,
                                        onChanged: (val){
                                          setState((){
                                            gender = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(" Male", style: TextStyle(color: colorWhite),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Radio<String>(
                                        activeColor: colorWhite,
                                        fillColor: MaterialStateColor.resolveWith((states) => colorWhite),
                                        value: "Female",
                                        groupValue: gender,
                                        onChanged: (val){
                                          setState((){
                                            gender = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(" Female", style: TextStyle(color: colorWhite),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    spacerLine(),
                    Row(
                      children: [
                        const Text("Theme       ", style: TextStyle(color: colorWhite),),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Radio<String>(
                                        value: "Light",
                                        toggleable: true,
                                        activeColor: colorWhite,
                                        fillColor: MaterialStateColor.resolveWith((states) => colorWhite),
                                        groupValue: theme,
                                        onChanged: (val){
                                          setState((){
                                            theme = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(" Light", style: TextStyle(color: colorWhite),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Radio<String>(
                                        activeColor: colorWhite,
                                        fillColor: MaterialStateColor.resolveWith((states) => colorWhite),
                                        value: "Dark",
                                        groupValue: theme,
                                        onChanged: (val){
                                          setState((){
                                            theme = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(" Dark", style: TextStyle(color: colorWhite),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: colorWhite,thickness: 0.1,height: 0.1),
                  ],
                ),
                const SizedBox(height: 50),
                showProgressBar ? const Center(child: CircularProgressIndicator()) : Container(
                  width: double.infinity,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        showProgressBar = true;
                      });
                      await authenticationController.saveUserInfo(
                          usernameTextEditingController.text.trim(),
                          nameTextEditingController.text.trim(),
                          bioTextEditingController.text.trim(),
                          linkTextEditingController.text.trim(),
                          gender
                      );
                      preferences.setIsDarkTheme(theme == "Dark" ? true : false);
                      /*await authenticationController.saveSocialMediaDetails(
                          facebookTextEditingController.text.trim(),
                          instagramTextEditingController.text.trim(),
                          whatsappTextEditingController.text.trim(),
                          twitterTextEditingController.text.trim(),
                          youtubeTextEditingController.text.trim()
                      );*/
                    },
                    child: const Center(child: Text("Update Now", style: boldTextStyleBlack_20)),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  spacerLine(){
    return Row(
      children: const [
        Text("                     "),
        Expanded(child: Divider(color: colorWhite,thickness: 0.1,height: 0.1)),
      ],
    );
  }
}
