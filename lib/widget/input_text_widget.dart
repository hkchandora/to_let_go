import 'package:flutter/material.dart';
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
      decoration: InputDecoration(
        labelText: labelString,
        prefixIcon: iconData != null
            ? Icon(iconData)
            : Padding(padding: const EdgeInsets.all(8), child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(assetReference!, width: 10))),
        labelStyle: const TextStyle(fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: colorGrey)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: colorGrey)
        ),
      ),
      obscureText: isObscure,
    );
  }
}
