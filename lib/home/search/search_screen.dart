import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';
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
        body: searchTextEditingController.text.isEmpty ? Center(
          child: Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset(AssetImagePath.search),
          )
        ) : StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("No Data"),
                    ],
                  ),
                );
              } else {
                return searchedUserList(snapshot);
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Please Wait"),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  searchedUserList(snapshot){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: const BoxDecoration(
            color: colorBlack,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(AssetImagePath.twitter),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("user name", style: boldTextStyleWhite_16),
                    Text("username@gmail.com", style: extraBoldTextStyleDarkGray_14.copyWith(color: colorLightWhite70))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
