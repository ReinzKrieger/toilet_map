import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewToiletController extends GetxController {
  var selectedDateTime = '9/28/2024 8:24 AM'.obs;
  var rating = 0.0.obs;
  var selectedPhotoPath = ''.obs;

  TextEditingController tagLocationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Fungsi untuk mengambil tanggal dan waktu
  void pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final dateTime = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
        selectedDateTime.value =
            '${pickedDate.month}/${pickedDate.day}/${pickedDate.year} ${pickedTime.format(Get.context!)}';
      }
    }
  }

  // Fungsi untuk mengambil foto dari galeri
  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedPhotoPath.value = pickedFile.path;
    }
  }

  // Fungsi untuk mengambil foto menggunakan kamera
  void takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedPhotoPath.value = pickedFile.path;
    }
  }

  // Fungsi untuk menyimpan data toilet
  void saveToilet() {
    // Implementasikan logika untuk menyimpan data
    Get.snackbar('Save', 'Toilet saved successfully');
  }
}
