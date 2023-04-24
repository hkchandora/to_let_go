import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_let_go/global.dart';
import 'package:to_let_go/home/home_screen.dart';
import 'package:to_let_go/model/user.dart' as user_model;
import 'package:to_let_go/on_boarding/login_screen.dart';
import 'package:to_let_go/on_boarding/registration_screen.dart';
import 'package:to_let_go/util/Preferences.dart';
import 'package:to_let_go/util/utility.dart';

class AuthenticationController extends GetxController{

  static AuthenticationController instanceAuth = Get.find();

  late Rx<User?> _currentUser;

  Rx<File?>? pickedFile;
  File? get profileImage => pickedFile!.value;


  Future<File> chooseImageFromGallery() async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImageFile != null){
      Get.snackbar(
        "Profile Image",
        "You have successfully selected your profile image",
      );
      pickedFile = Rx<File>(File(pickedImageFile.path));
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


  createAccountForNewUser(File imageFile, String userName, String userEmail, String userPassword) async {
    try{
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword);

      String imageDownloadUrl = await uploadImageToStorage(imageFile);
      String version = await Utility.getVersionInfo();
      user_model.User user = user_model.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
        appVersion: version,
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(credential.user!.uid).set(user.toJson());

      Preferences preferences = Preferences();
      preferences.setUserEmail(userEmail);
      preferences.setUserUid(credential.user!.uid);
      preferences.setUserName(userName);
      preferences.setUserprofileImageUrl(imageDownloadUrl);

      Get.snackbar("Account Creation Successful","");
    } catch (error){
      Get.snackbar("Account Creation Unsuccessful","Error occurred while creating account. Try Again.");
      showProgressBar = false;
      Get.to(const LoginScreen());
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


  logInUserNow(String userEmail, String userPassword) async {
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

      Get.snackbar("Logged in Successful", "you're logged-in successful");
      showProgressBar = false;
    } catch(error){
      Get.snackbar("Login Unsuccessful", "Error occurred while sign in authentication");
      showProgressBar = false;
      // Get.to(const RegistrationScreen());
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