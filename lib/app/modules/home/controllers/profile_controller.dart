import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/models/user_model.dart';
import 'package:toiletmap/app/utils/snackbar.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  // Observable fields for name, username, email, and bio
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var name = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var bio = ''.obs;
  var userData = Rxn<UserList>();

  // TextEditingControllers for handling text input
  TextEditingController nameTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController bioTextController = TextEditingController();

  @override
  void onInit() {
    // Listeners to update observable fields when text input changes
    nameTextController.addListener(() {
      name.value = nameTextController.text;
    });
    usernameTextController.addListener(() {
      username.value = usernameTextController.text;
    });
    emailTextController.addListener(() {
      email.value = emailTextController.text;
    });
    bioTextController.addListener(() {
      bio.value = bioTextController.text;
    });
    super.onInit();
    if (auth.currentUser != null) {
      fetchUserData();
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (auth.currentUser != null) {
      fetchUserData();
    }
  }

  @override
  void onClose() {
    // Dispose of the text controllers when the controller is destroyed
    nameTextController.dispose();
    usernameTextController.dispose();
    emailTextController.dispose();
    bioTextController.dispose();
    super.onClose();
  }

  Future<void> fetchUserData() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        print("User document data: ${userDoc.data()}");
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        userData.value = UserList.fromJson(data, uid);

        emailTextController.text = userData.value!.email;
        nameTextController.text = userData.value!.name;
        usernameTextController.text = userData.value!.username;
        bioTextController.text = userData.value!.bio;
      } else {
        print("No user document found for UID: $uid");
        Get.snackbar('Error', 'No user data found');
      }
    } catch (e) {
      print("Error fetching user data: $e");
      Get.snackbar('Error', 'Failed to fetch user data');
    }
  }

  // Save function (you can define this based on your specific logic)
  Future<void> saveProfile(String params) async {
    String uid = auth.currentUser!.uid;
    if (params == 'name') {
      await addFieldToDocument('users', uid, params, name.value);
    } else if (params == 'bio') {
      await addFieldToDocument('users', uid, params, bio.value);
    } else if (params == 'email') {
      await addFieldToDocument('users', uid, params, email.value);
    } else if (params == 'username') {
      await addFieldToDocument('users', uid, params, username.value);
    }
  }

  Future<void> addFieldToDocument(String collectionPath, String documentId,
      String fieldName, dynamic value) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .update({fieldName: value});
      print("Field added successfully");
      SnackBarUtil.showSuccess("Profile update success !");

      Get.offAndToNamed(Routes.profile);
    } catch (e) {
      print("Error adding field: $e");
      SnackBarUtil.showError("$e");
    }
  }
}
