import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String keyUserName = "userName";
  static const String keyUserUid = "userUid";
  static const String keyUserProfileImageUrl = "userProfileImageUrl";
  static const String keyUserEmail = "userEmail";
  static const String keyUserYoutube = "userYoutube";
  static const String keyUserFacebook = "userFacebook";
  static const String keyUserWhatsapp = "userWhatsapp";
  static const String keyUserTwitter = "userTwitter";
  static const String keyUserInstagram = "userInstagram";
  static const String keyUserFollowing = "userFollowing";
  static const String keyUserFollowers = "userFollowers";
  static const String keyUserPosts = "userPosts";

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(keyUserName) ?? "";
    return userName;
  }

  setUserName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserName, value);
  }

  Future<String> getUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userUid = prefs.getString(keyUserUid) ?? "";
    return userUid;
  }

  setUserUid(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserUid, value);
  }

  Future<String> getUserprofileImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileImageUrl = prefs.getString(keyUserProfileImageUrl) ?? "";
    return userProfileImageUrl;
  }

  setUserprofileImageUrl(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserProfileImageUrl, value);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString(keyUserEmail) ?? "";
    return userEmail;
  }

  setUserEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserEmail, value);
  }

  Future<String> getUserYoutube() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userYoutube = prefs.getString(keyUserYoutube) ?? "";
    return userYoutube;
  }

  setUserYoutube(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserYoutube, value);
  }


  Future<String> getUserFacebook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userFacebook = prefs.getString(keyUserFacebook) ?? "";
    return userFacebook;
  }

  setUserFacebook(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserFacebook, value);
  }

  Future<String> getUserWhatsapp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userWhatsapp = prefs.getString(keyUserWhatsapp) ?? "";
    return userWhatsapp;
  }

  setUserWhatsapp(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserWhatsapp, value);
  }

  Future<String> getUserTwitter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userTwitter = prefs.getString(keyUserTwitter) ?? "";
    return userTwitter;
  }

  setUserTwitter(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserTwitter, value);
  }

  Future<String> getUserInstagram() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userInstagram = prefs.getString(keyUserInstagram) ?? "";
    return userInstagram;
  }

  setUserInstagram(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUserInstagram, value);
  }

  Future<int> getUserFollowing() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userFollowing = prefs.getInt(keyUserFollowing) ?? 0;
    return userFollowing;
  }

  setUserFollowing(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyUserFollowing, value);
  }

  Future<int> getUserFollowers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userFollowers = prefs.getInt(keyUserFollowers) ?? 0;
    return userFollowers;
  }

  setUserFollowers(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyUserFollowers, value);
  }

  Future<int> getUserPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userPost = prefs.getInt(keyUserPosts) ?? 0;
    return userPost;
  }

  setUserPosts(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyUserPosts, value);
  }

  clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
