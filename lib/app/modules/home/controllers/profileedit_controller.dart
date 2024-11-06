import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toiletmap/app/modules/home/models/user_model.dart';

class ProfileEditController extends GetxController {
  var name = "".obs;
  var username = "".obs;
  var email = "".obs;
  var bio = "".obs;
  var profilePhoto = "".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userData = Rxn<UserList>();

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Fungsi untuk mengambil gambar dari galeri
  void pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePhoto.value = pickedFile.path;
    }
  }

  // Fungsi untuk mengambil gambar dari kamera
  void pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profilePhoto.value = pickedFile.path;
    }
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

        email.value = userData.value!.email;
        name.value = userData.value!.name;
        username.value = userData.value!.username;
        bio.value = userData.value!.bio;
      } else {
        print("No user document found for UID: $uid");
        Get.snackbar('Error', 'No user data found');
      }
    } catch (e) {
      print("Error fetching user data: $e");
      Get.snackbar('Error', 'Failed to fetch user data');
    }
  }

  // Fungsi untuk mengembalikan file gambar
  File getImageFile() {
    return File(profilePhoto.value);
  }
}
