import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoData {
  String? name;
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
  int? likes;

  UserInfoData(
      {this.name,
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
        this.likes,
      });

  Map<String, dynamic> toJson() => {
    "name": name,
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
    "likes": likes
  };

  static UserInfoData fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return UserInfoData(
      name: dataSnapshot["name"],
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
      likes: dataSnapshot["likes"],
    );
  }

}