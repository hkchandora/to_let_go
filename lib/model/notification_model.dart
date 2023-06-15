import 'package:cloud_firestore/cloud_firestore.dart';

class StoreNotification {
  String? name;
  String? userName;
  String? uid;
  String? image;
  String? notificationTitle;
  String? notificationType; //follow, like, comment, commentLike
  String? dateTime;

  StoreNotification({
    this.name,
    this.userName,
    this.uid,
    this.image,
    this.notificationTitle,
    this.notificationType,
    this.dateTime
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": userName,
    "uid": uid,
    "image": image,
    "notificationTitle": notificationTitle,
    "notificationType": notificationType,
    "dateTime": dateTime,
  };

  static StoreNotification fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return StoreNotification(
      name: dataSnapshot["name"],
      userName: dataSnapshot["username"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      notificationTitle: dataSnapshot["notificationTitle"],
      notificationType: dataSnapshot["notificationType"],
      dateTime: dataSnapshot["dateTime"],
    );
  }
}