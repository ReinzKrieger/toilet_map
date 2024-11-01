import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditController extends GetxController {
  var name = "John".obs;
  var username = "John Doe".obs;
  var email = "Feistalcy@gmail.com".obs;
  var bio = "".obs;
  var profilePhoto = "".obs;

  final ImagePicker picker = ImagePicker();

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

  // Fungsi untuk mengembalikan file gambar
  File getImageFile() {
    return File(profilePhoto.value);
  }
}
