import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Observable fields for name, username, email, and bio
  var name = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var bio = ''.obs;

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

  // Save function (you can define this based on your specific logic)
  void saveProfile() {
    // Save logic for profile (name, username, email, bio)
    print("Name: ${name.value}");
    print("Username: ${username.value}");
    print("Email: ${email.value}");
    print("Bio: ${bio.value}");
    Get.snackbar("Success", "Profile saved successfully!",
        snackPosition: SnackPosition.BOTTOM);
  }
}