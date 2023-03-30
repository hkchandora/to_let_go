import 'package:flutter/material.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/widget/input_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
            ],
          ),
        ),
      ),
    );
  }
}
