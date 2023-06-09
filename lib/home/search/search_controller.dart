import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{

  getSearchedUser(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    List searchedUserDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    List finalSearchedList = [];
    finalSearchedList.addAll(
      searchedUserDataList.where((element) => element['name'].toString().contains(name) &&
          element['uid'] != FirebaseAuth.instance.currentUser!.uid),
    );
    return finalSearchedList;
  }
}