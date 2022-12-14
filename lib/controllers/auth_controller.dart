// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tik_tok_flutter/constants.dart';
// import 'package:tik_tok_flutter/models/user.dart' as model;

// class AuthController extends GetxController {
//   static AuthController instance = Get.find();

//   late Rx<File?> _pickedImage;

//   File? get profilePhoto => _pickedImage.value;

//   void imagePicker() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       Get.snackbar('Profile Picture', 'Sucefully Added');
//     }
//     _pickedImage = Rx<File?>(File(pickedImage!.path));
//   }

//   Future<String> _uploadToStorge(File image) async {
//     Reference ref = fireStorage
//         .ref()
//         .child('ProfilePics')
//         .child(firebaseAuth.currentUser!.uid);
//     UploadTask uploadTask = ref.putFile(image);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   //Regestring the user
//   void registerUser(
//       String username, String email, String password, File? image) async {
//     try {
//       if (username.isNotEmpty &&
//           email.isNotEmpty &&
//           password.isNotEmpty &&
//           image != null) {
//         //Save out the user in firebase auth
//         UserCredential userCredential = await firebaseAuth
//             .createUserWithEmailAndPassword(email: email, password: password);
//         String downloadUrl = await _uploadToStorge(image);
//         model.User user = model.User(
//             email: email,
//             uid: userCredential.user!.uid,
//             profilePhoto: downloadUrl,
//             name: username);
//         await fireStore
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .set(user.toJson());
//       } else {
//         Get.snackbar(
//             'Error creating an Account', 'One of the above field is missing');
//       }
//     } catch (e) {
//       Get.snackbar('Error creating an Account', e.toString());
//     }
//   }
// }

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok_flutter/constants.dart';
import 'package:tik_tok_flutter/models/user.dart' as model;
import 'package:tik_tok_flutter/views/screens/auth/login_screen_auth.dart';
import 'package:tik_tok_flutter/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        Get.snackbar(
          'Congrats',
          'Your Account was created Succefully',
        );
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
