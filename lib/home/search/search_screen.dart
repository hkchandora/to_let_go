import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/profile/profile_screen.dart';
import 'package:to_let_go/home/search/search_controller.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:to_let_go/util/style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchTextEditingController = TextEditingController();
  SearchController searchController = Get.put(SearchController());
  Future<QuerySnapshot>? futureSearchResults;
  List searchedUser = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorBlack,
          elevation: 0,
          actions: [
            Expanded(
              child: TextField(
                controller: searchTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: colorWhite),
                decoration: InputDecoration(
                    hintText: "Search...",
                    counterText: "",
                    prefixIcon: const Icon(Icons.search, color: colorWhite),
                    labelStyle: const TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: colorGrey)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: colorGrey),
                    ),
                    focusColor: colorGrey
                ),
                onChanged: (String value) async {
                  searchedUser.clear();
                  searchedUser = await searchController.getSearchedUser(searchTextEditingController.text.toLowerCase());
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        body: mainBody()
      ),
    );
  }

  mainBody() {
    if(searchTextEditingController.text.isEmpty){
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset(AssetImagePath.search),
          )
      );
    } else if(searchTextEditingController.text.isNotEmpty && searchedUser.isEmpty){
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset(AssetImagePath.noData),
          )
      );
    } else {
      return searchedUserList();
    }
  }

  searchedUserList(){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchedUser.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Get.to(() => ProfileScreen(Strings.search, searchedUser[index]['uid']));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: const BoxDecoration(
              color: colorBlack,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(searchedUser[index]['image'].toString()),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(searchedUser[index]['username'].toString(), style: boldTextStyleWhite_16),
                      Text(searchedUser[index]['name'].toString(), style: extraBoldTextStyleDarkGray_14.copyWith(color: colorLightWhite))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
