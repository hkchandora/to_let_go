import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_let_go/widget/widget_common.dart';

class SearchController extends GetxController{

  getSearchedUser(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where("name", isGreaterThanOrEqualTo: name).get();
    List searchedUserDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("searchedUserDataList");
    print("${searchedUserDataList.length}");
    return searchedUserDataList;
  }
}