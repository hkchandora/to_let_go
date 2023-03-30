import 'package:flutter/material.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/colors.dart';
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
  bool showProgressBar = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
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
                         onTap: (){
                           setState(() {
                             showProgressBar = true;
                           });
                         },
                         child: const Center(child: Text("Login", style: boldTextStyleBlack_20)),
                       ),
                     ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Text("Don't have an Account?", style: mediumTextStyleLightGray_16),
                          Text("SignUp Now", style: extraBoldTextStyleWhite_18),

                        ],
                      ),
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}
