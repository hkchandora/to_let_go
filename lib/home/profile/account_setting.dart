import 'package:flutter/material.dart';
import 'package:to_let_go/authentication/authentication_controller.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/util/preferences.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/widget/input_text_widget.dart';
import 'package:to_let_go/widget/widget_common.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {

  TextEditingController facebookTextEditingController = TextEditingController();
  TextEditingController instagramTextEditingController = TextEditingController();
  TextEditingController whatsappTextEditingController = TextEditingController();
  TextEditingController twitterTextEditingController = TextEditingController();
  TextEditingController youtubeTextEditingController = TextEditingController();
  var authenticationController = AuthenticationController.instanceAuth;
  Preferences preferences = Preferences();
  String? profileImage;

  @override
  void initState() {
    getDataFromPreference();
    super.initState();
  }

  getDataFromPreference() async {
    String userProfileImage = await preferences.getUserprofileImageUrl();
    String userFacebook = await preferences.getUserFacebook();
    String userInstagram = await preferences.getUserInstagram();
    String userWhatsapp = await preferences.getUserWhatsapp();
    String userTwitter = await preferences.getUserTwitter();
    String userYoutube = await preferences.getUserYoutube();

    setState(() {
      profileImage = userProfileImage;
      facebookTextEditingController.text = userFacebook;
      instagramTextEditingController.text = userInstagram;
      whatsappTextEditingController.text = userWhatsapp;
      twitterTextEditingController.text = userTwitter;
      youtubeTextEditingController.text = userYoutube;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account Setting"),
          centerTitle: true,
          backgroundColor: colorBlack,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: const ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: profileImage != null ? CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(profileImage!),
                    backgroundColor: colorBlack,
                  ) : const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                    backgroundColor: colorBlack,
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Upload Your Social Links :-", style: regularTextStyleWhite_24),
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
                const SizedBox(height: 30),
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
                      await authenticationController.saveSocialMediaDetails(
                         facebookTextEditingController.text.trim(),
                        instagramTextEditingController.text.trim(),
                        whatsappTextEditingController.text.trim(),
                        twitterTextEditingController.text.trim(),
                        youtubeTextEditingController.text.trim()
                      );
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
}
