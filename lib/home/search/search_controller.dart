import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{

  getSearchedUser(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where("name", isGreaterThanOrEqualTo: name).get();
    List searchedUserDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return searchedUserDataList;
  }
}