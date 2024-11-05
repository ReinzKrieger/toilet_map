import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:toiletmap/app/routes/app_pages.dart';

class NewToiletController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var selectedDateTime = '9/28/2024 8:24 AM'.obs;
  var rating = 0.0.obs;
  var selectedPhotoPath = ''.obs;
  var selectedPhotoName = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var mapMarker = Rxn<Marker>();
  var selectedDate = Rxn<DateTime>();

  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  final Location location = Location();
  final isLoading = true.obs;

  TextEditingController tagLocationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initGeolocator();
  }

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

        if (dateTime != "") {
          selectedDate.value = dateTime;
        }
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
      selectedPhotoName.value = pickedFile.name;
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

  void setMapMarker(LatLng position) {
    final marker = Marker(
        markerId: MarkerId('single_mark'),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Pilih Disini',
        ));
    mapMarker.value = marker;
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    tagLocationController.text = "${latitude.value},${longitude.value}";
  }

  Future<void> _initGeolocator() async {
    try {
      // Inisialisasi dan cek location service
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Error',
          'Location services are disabled. Please enable location services',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Cek dan minta permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            'Error',
            'Location permissions are denied',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Error',
          'Location permissions are permanently denied, please enable in Settings',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Setelah semua pengecekan, ambil posisi
      await getCurrentLocation();
    } catch (e) {
      print('Error initializing geolocator: $e');
      Get.snackbar(
        'Error',
        'Failed to initialize location services: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      // Get current position with new locationSettings parameter
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          timeLimit: const Duration(seconds: 5),
        ),
      );

      currentLat.value = position.latitude;
      currentLng.value = position.longitude;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('Error $e');
      isLoading.value = false;
    }
  }

  // Fungsi untuk menyimpan data toilet
  void saveToilet() {
  Map<String, dynamic> data = {
    "userId": auth.currentUser!.uid, // Add userId to associate the marker with the user
    "latitude": latitude.value,
    "longitude": longitude.value,
    "title": "Toilet Umum",
    "description": descriptionController.text,
    "rating": rating.value,
    "imageUrl": selectedPhotoPath.value,
    // Add any other fields as needed
  };

  try {
    print("User ID: ${auth.currentUser!.uid}");
    firebaseFirestore
        .collection('LocationMark')
        .add(data) // Use add() to generate a unique document ID
        .then((_) {
          print("Map marked successfully");
          Get.offNamed(Routes.profile);
        });
  } catch (e) {
    Get.snackbar("Oops", "Message: $e");
  }
}

}
