import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoData {
  String? name;
  String? userName;
  String? uid;
  String? image;
  String? email;
  String? appVersion;
  String? youtube;
  String? facebook;
  String? whatsapp;
  String? twitter;
  String? instagram;
  int? following;
  int? followers;
  int? posts;
  List? followingUidList;
  List? followersUidList;

  UserInfoData(
      {this.name,
        this.userName,
        this.uid,
        this.image,
        this.email,
        this.appVersion,
        this.youtube,
        this.facebook,
        this.whatsapp,
        this.twitter,
        this.instagram,
        this.following,
        this.followers,
        this.posts,
        this.followingUidList,
        this.followersUidList,
      });

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": userName,
    "uid": uid,
    "image": image,
    "email": email,
    "appVersion": appVersion,
    "youtube": youtube,
    "facebook": facebook,
    "whatsapp": whatsapp,
    "twitter": twitter,
    "instagram": instagram,
    "following": following,
    "followers": followers,
    "posts": posts,
    "followingUidList": followingUidList,
    "followersUidList": followersUidList,
  };

  static UserInfoData fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return UserInfoData(
      name: dataSnapshot["name"],
      userName: dataSnapshot["username"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
      appVersion: dataSnapshot["appVersion"],
      youtube: dataSnapshot["youtube"],
      whatsapp: dataSnapshot["whatsapp"],
      facebook: dataSnapshot["facebook"],
      twitter: dataSnapshot["twitter"],
      instagram: dataSnapshot["instagram"],
      following: dataSnapshot["following"],
      followers: dataSnapshot["followers"],
      posts: dataSnapshot["posts"],
      followingUidList: dataSnapshot["followingUidList"],
      followersUidList: dataSnapshot["followersUidList"],
    );
  }
}

class ChildUserInfo {
  String? uid;
  String? username;
  String? name;
  String? image;
  String? email;

  ChildUserInfo({this.username, this.name, this.uid, this.email, this.image});

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "uid": uid,
    "image": image,
    "email": email
  };

  static ChildUserInfo fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return ChildUserInfo(
      uid: dataSnapshot["uid"],
      username: dataSnapshot["username"],
      name: dataSnapshot["name"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
    );
  }
}