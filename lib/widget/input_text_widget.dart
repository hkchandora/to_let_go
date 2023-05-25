import 'package:flutter/material.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/util/colors.dart';

class InputTextWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final IconData? iconData;
  final String? assetReference;
  final String? labelString;
  final bool isObscure;

  const InputTextWidget({Key? key,
    required this.textEditingController,
    this.textInputType,
    this.iconData,
    this.assetReference,
    required this.labelString,
    required this.isObscure
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      enabled: !showProgressBar,
      maxLength: textInputType == TextInputType.phone ? 10 : 10000,
      style: const TextStyle(color: colorWhite),
      decoration: InputDecoration(
        labelText: labelString,
        counterText: "",
        prefixIcon: iconData != null
            ? Icon(iconData, color: colorWhite)
            : Padding(padding: const EdgeInsets.all(8), child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(assetReference!, width: 10))),
        labelStyle: const TextStyle(fontSize: 18, color: colorWhite),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: colorGrey)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: colorGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: colorGrey),
        ),
        focusColor: colorGrey
      ),
      obscureText: isObscure,
    );
  }
}
