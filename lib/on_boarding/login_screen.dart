import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:to_let_go/authentication/authentication_controller.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/on_boarding/registration_screen.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/constants.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/widget/input_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  RegExp emailRegex = RegExp(RegexValidator.emailRegex);
  var authenticationController = AuthenticationController.instanceAuth;


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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width)/4),
                  child: Image.asset(AssetImagePath.appLogo),
                ),
                const SizedBox(height: 30),
                const Text("Welcome\nGlad to see you!", style: boldTextStyleLightGray_30, textAlign: TextAlign.center),
                const SizedBox(height: 30),
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
                             if(emailTextEditingController.text.trim().isEmpty){
                               Get.snackbar("Error !!", "Email can't be empty");
                             } else if (!emailRegex.hasMatch(emailTextEditingController.text.toString().trim())) {
                               Get.snackbar("Error !!", "Invalid email");
                             } else if(passwordTextEditingController.text.trim().isEmpty){
                               Get.snackbar("Error !!", "Password can't be empty");
                             } else {
                               setState(() {
                                 showProgressBar = true;
                               });
                               await authenticationController.logInUserNow(
                                   emailTextEditingController.text.trim().toString(),
                                   passwordTextEditingController.text.toString()
                               );
                               setState(() {});
                             }
                           },
                           child: const Center(child: Text("Login", style: boldTextStyleBlack_20)),
                         ),
                       ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Don't have an Account? ", style: mediumTextStyleLightGray_16),
                            InkWell(
                              onTap: (){
                                Get.to(const RegistrationScreen());
                              },
                              child: const Text("SignUp Now", style: extraBoldTextStyleWhite_18),
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
