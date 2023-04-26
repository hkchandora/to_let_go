import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/authentication/authentication_controller.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/constants.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/widget/input_text_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);


  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  var authenticationController = AuthenticationController.instanceAuth;
  RegExp emailRegex = RegExp(RegexValidator.emailRegex);
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text("Create Account\nto get Started Now!", style: boldTextStyleLightGray_30, textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width)/4),
                  child: GestureDetector(
                    onTap: () async {
                      profileImage = null;
                      profileImage = await authenticationController.chooseImageFromGallery();
                      setState((){});
                    },
                    child: profileImage == null ? const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                      backgroundColor: colorBlack,
                    ) : ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.file(
                        authenticationController.profileImage!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InputTextWidget(
                  textEditingController: userNameTextEditingController,
                  textInputType: TextInputType.text,
                  labelString: "User Name",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: emailTextEditingController,
                  textInputType: TextInputType.emailAddress,
                  labelString: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                InputTextWidget(
                  textEditingController: passwordTextEditingController,
                  textInputType: TextInputType.visiblePassword,
                  labelString: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
                const SizedBox(height: 30),
                showProgressBar
                    ? const CircularProgressIndicator()
                    : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if(profileImage == null){
                            Get.snackbar("Error !!", "Please set your profile.");
                          } else if(userNameTextEditingController.text.trim().isEmpty){
                            Get.snackbar("Error !!", "User Name can't be empty");
                          } else if(emailTextEditingController.text.trim().isEmpty){
                            Get.snackbar("Error !!", "Email can't be empty");
                          } else if (!emailRegex.hasMatch(emailTextEditingController.text.toString().trim())) {
                            Get.snackbar("Error !!", "Invalid email");
                          } else if(passwordTextEditingController.text.trim().isEmpty){
                            Get.snackbar("Error !!", "Password can't be empty");
                          } else {
                            setState(() {
                              showProgressBar = true;
                            });
                            await authenticationController.createAccountForNewUser(
                                authenticationController.profileImage!,
                                userNameTextEditingController.text.toString().trim().toLowerCase(),
                                emailTextEditingController.text.toString().trim().toLowerCase(),
                                passwordTextEditingController.text.toString().trim()
                            );
                          }
                        },
                        child: const Center(child: Text("Sign Up", style: boldTextStyleBlack_20)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Already have an account? ", style: mediumTextStyleLightGray_16),
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Text("Login Now", style: extraBoldTextStyleWhite_18),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
