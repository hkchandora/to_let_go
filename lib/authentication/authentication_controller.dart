import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/home_screen.dart';
import 'package:to_let_go/model/user.dart' as user_model;
import 'package:to_let_go/on_boarding/login_screen.dart';
import 'package:to_let_go/util/colors.dart';
import 'package:to_let_go/util/preferences.dart';
import 'package:to_let_go/util/utility.dart';

class AuthenticationController extends GetxController{

  static AuthenticationController instanceAuth = Get.find();

  late Rx<User?> _currentUser;

  Rx<File?>? pickedFile;
  File? get profileImage => pickedFile!.value;


  Future<File> chooseImageFromGallery() async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImageFile != null){
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: pickedImageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        cropStyle: CropStyle.circle,
        compressQuality: 50,
        uiSettings: [
          AndroidUiSettings(
              toolbarColor: colorBlack,
              toolbarTitle: "Crop Image",
              toolbarWidgetColor: colorWhite,
              backgroundColor: colorBg,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true)

        ],
      );

      if(cropped !=  null){
        pickedFile = Rx<File>(File(cropped.path));
      }
    }
    return pickedFile!.value!;
  }


  void captureImageWithCamera() async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedImageFile != null){
      Get.snackbar(
        "Profile Image",
        "You have successfully captured your profile image with Phone Camera.",
      );
      pickedFile = Rx<File>(File(pickedImageFile.path));
    }
  }


  Future<bool> createAccountForNewUser(File imageFile, String userName, String userEmail, String userPassword) async {
    try{
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword);

      String imageDownloadUrl = await uploadImageToStorage(imageFile);
      String version = await Utility.getVersionInfo();
      user_model.UserInfoData user = user_model.UserInfoData(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
        appVersion: version,
        following: 0,
        followers: 0,
        posts: 0
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(credential.user!.uid).set(user.toJson());

      Preferences preferences = Preferences();
      preferences.setUserEmail(userEmail);
      preferences.setUserUid(credential.user!.uid);
      preferences.setUserName(userName);
      preferences.setUserprofileImageUrl(imageDownloadUrl);
      preferences.setUserFollowing(0);
      preferences.setUserFollowers(0);
      preferences.setUserPosts(0);

      Get.snackbar("Account Creation Successful","");
      showProgressBar = false;
      return true;
    } catch (error){
      Get.snackbar("Account Creation Unsuccessful","Error occurred while creating account. Try Again.");
      showProgressBar = false;
      return false;
      // Get.to(const LoginScreen());
    }
  }


  Future<String> uploadImageToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadedUrlOfImage = await taskSnapshot.ref.getDownloadURL();
    return downloadedUrlOfImage;
  }


  Future<bool> logInUserNow(String userEmail, String userPassword) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Preferences preferences = Preferences();
      preferences.setUserEmail(userEmail);
      preferences.setUserUid(FirebaseAuth.instance.currentUser!.uid);
      preferences.setUserName((userDocumentSnapshot.data() as Map<String, dynamic>)["name"]);
      preferences.setUserprofileImageUrl((userDocumentSnapshot.data() as Map<String, dynamic>)["image"]);
      preferences.setUserFacebook((userDocumentSnapshot.data() as Map<String, dynamic>)["facebook"]);
      preferences.setUserInstagram((userDocumentSnapshot.data() as Map<String, dynamic>)["instagram"]);
      preferences.setUserWhatsapp((userDocumentSnapshot.data() as Map<String, dynamic>)["whatsapp"]);
      preferences.setUserTwitter((userDocumentSnapshot.data() as Map<String, dynamic>)["twitter"]);
      preferences.setUserYoutube((userDocumentSnapshot.data() as Map<String, dynamic>)["youtube"]);
      preferences.setUserFollowing((userDocumentSnapshot.data() as Map<String, dynamic>)["following"]);
      preferences.setUserFollowers((userDocumentSnapshot.data() as Map<String, dynamic>)["followers"]);
      preferences.setUserPosts((userDocumentSnapshot.data() as Map<String, dynamic>)["posts"]);

      Get.snackbar("Logged in Successful", "you're logged-in successful");
      showProgressBar = false;
      return true;
    } catch(error){
      Get.snackbar("Login Unsuccessful", "Error occurred while sign in authentication");
      showProgressBar = false;
      return false;
    }
  }

  saveSocialMediaDetails(String facebook, String instagram, String whatsapp, String twitter, String youtube) async {
    try{
      // DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .get();

      // user_model.UserInfoData user = user_model.UserInfoData(
      //   name: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
      //   email: (userDocumentSnapshot.data() as Map<String, dynamic>)["email"],
      //   image: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
      //   uid: (userDocumentSnapshot.data() as Map<String, dynamic>)["uid"],
      //   appVersion: (userDocumentSnapshot.data() as Map<String, dynamic>)["appVersion"],
      //   facebook: facebook,
      //   instagram: instagram,
      //   whatsapp: whatsapp,
      //   twitter: twitter,
      //   youtube: youtube,
      //   following: (userDocumentSnapshot.data() as Map<String, dynamic>)["following"],
      //   followers: (userDocumentSnapshot.data() as Map<String, dynamic>)["followers"],
      //   posts: (userDocumentSnapshot.data() as Map<String, dynamic>)["posts"],
      // );

      // await FirebaseFirestore.instance.collection("users")
      //     .doc(FirebaseAuth.instance.currentUser!.uid).set(user.toJson());
      await FirebaseFirestore.instance.collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid).update({
        "facebook": facebook,
        "instagram": instagram,
        "whatsapp": whatsapp,
        "twitter": twitter,
        "youtube": youtube,
      });

      Preferences preferences = Preferences();
      preferences.setUserFacebook(facebook);
      preferences.setUserInstagram(instagram);
      preferences.setUserWhatsapp(whatsapp);
      preferences.setUserTwitter(twitter);
      preferences.setUserYoutube(youtube);
      Get.back();
    } catch (error){
      Get.snackbar("Error Occurred","Something went wrong.");
    }
    showProgressBar = false;
  }


  Future<bool> isUniqueName(String userName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    List allUserName = querySnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['name']).toList();
    if(allUserName.contains(userName)){
      return false;
    } else {
      return true;
    }
  }


  goToScreen(User? currentUser){
    if(currentUser == null){
       Get.offAll(const LoginScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  @override
  void onReady() {
    super.onReady();

    _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_currentUser, goToScreen);
  }
}