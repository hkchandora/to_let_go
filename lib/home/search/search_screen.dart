import 'package:flutter/material.dart';
import 'package:to_let_go/util/style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Search screen",
          style: extraBoldTextStyleWhite_18,
        ),
      ),
    );
  }
}
