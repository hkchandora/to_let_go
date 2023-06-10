import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? uid;
  String? username;
  String? name;
  String? commentText;
  String? profileImage;
  String? dateTime;
  String? commentId;

  Comment({this.uid, this.username, this.name, this.commentText, this.profileImage, this.dateTime, this.commentId});

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "username": username,
    "name": name,
    "commentText": commentText,
    "profileImage": profileImage,
    "dateTime": dateTime,
    "commentId": commentId
  };

  static Comment fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Comment(
      uid: dataSnapshot["uid"],
      username: dataSnapshot["username"],
      name: dataSnapshot["name"],
      commentText: dataSnapshot["commentText"],
      profileImage: dataSnapshot["profileImage"],
      dateTime: dataSnapshot["dateTime"],
      commentId: dataSnapshot["commentId"],
    );
  }
}