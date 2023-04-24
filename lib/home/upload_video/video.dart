import 'package:cloud_firestore/cloud_firestore.dart';

class Video{

  String? userId;
  String? userName;
  String? userProfileImage;
  String? videoID;
  int? totalComments;
  int? totalShares;
  List? likeList;
  String? artistSongName;
  String? descriptionTags;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;


  Video({
    this.userId,
    this.userName,
    this.userProfileImage,
    this.videoID,
    this.totalComments,
    this.totalShares,
    this.likeList,
    this.artistSongName,
    this.descriptionTags,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime
  });

  Map<String, dynamic> toJson() => {
    "userId" : userId,
    "userName" : userName,
    "userImage" : userProfileImage,
    "videoID" : videoID,
    "totalComments" : totalComments,
    "totalShares" : totalShares,
    "likeList" : likeList,
    "artistSongName" : artistSongName,
    "descriptionTags" : descriptionTags,
    "videoUrl" : videoUrl,
    "thumbnailUrl" : thumbnailUrl,
    "publishedDateTime" : publishedDateTime
  };

  static Video fromDocumentSnapshot(DocumentSnapshot snapshot){
    var docSnapshot = snapshot.data() as Map<String, dynamic>;

    return Video(
      userId : docSnapshot["userId"],
      userName : docSnapshot["userName"],
      userProfileImage : docSnapshot["userImage"],
      videoID : docSnapshot["videoID"],
      totalComments : docSnapshot["totalComments"],
      totalShares : docSnapshot["totalShares"],
      likeList : docSnapshot["likeList"],
      artistSongName : docSnapshot["artistSongName"],
      descriptionTags : docSnapshot["descriptionTags"],
      videoUrl : docSnapshot["videoUrl"],
      thumbnailUrl : docSnapshot["thumbnailUrl"],
      publishedDateTime : docSnapshot["publishedDateTime"],
    );
  }
}