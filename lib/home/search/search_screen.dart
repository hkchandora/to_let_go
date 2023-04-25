import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';
import 'package:to_let_go/widget/input_text_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Expanded(
                child: InputTextWidget(
                  textEditingController: searchTextEditingController,
                  textInputType: TextInputType.text,
                  labelString: "Search...",
                  iconData: Icons.search,
                  isObscure: false,
                ),
            )
          ],
        ),
        body: Center(
          child: Text(
            "Search screen",
            style: extraBoldTextStyleWhite_18,
          ),
        ),
      ),
    );
  }
}
