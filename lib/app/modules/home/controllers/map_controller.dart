import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MapController extends GetxController {
  var selectedIndex = 0.obs; // Untuk BottomNavigationBar
  var selectedMapType = 0.obs; // Untuk peta (Global, Friends, Individual)

  // Contoh data toilet untuk setiap jenis peta
  var globalToilets = [
    {'latitude': -6.200000, 'longitude': 106.816666},
    {'latitude': -7.250445, 'longitude': 112.768845},
  ].obs;

  var friendsToilets = [
    {'latitude': -8.583333, 'longitude': 116.116667},
    {'latitude': -9.583333, 'longitude': 120.116667},
  ].obs;

  var individualToilets = [
    {'latitude': -10.583333, 'longitude': 123.116667},
    {'latitude': -11.583333, 'longitude': 125.116667},
  ].obs;

  // Fungsi untuk menangani perubahan jenis peta
  void onMapTypeChanged(int index) {
    selectedMapType.value = index;
    update();
  }

  // Fungsi untuk membangun peta dan menampilkan toilet markers berdasarkan jenis peta
  Widget buildMap() {
    List<Map<String, double>> toilets = [];

    // Pilih data toilet sesuai jenis peta yang dipilih
    if (selectedMapType.value == 0) {
      toilets = globalToilets;
    } else if (selectedMapType.value == 1) {
      toilets = friendsToilets;
    } else {
      toilets = individualToilets;
    }

    return Container(
      color: Colors.greenAccent, // Ganti dengan widget peta sebenarnya (misal: Google Maps)
      child: Column(
        children: [
          Text('Showing ${selectedMapType.value == 0 ? "Global" : selectedMapType.value == 1 ? "Friends" : "Individual"} Map'),
          // Daftar marker untuk toilet
          ...toilets.map((toilet) => ListTile(
            title: Text('Toilet at ${toilet['latitude']}, ${toilet['longitude']}'),
          )),
        ],
      ),
    );
  }

  // Fungsi untuk menangani ketika tombol "Mark the toilet" ditekan
  void onMarkToiletPressed() {
    Get.snackbar('Toilet Marked', 'Toilet successfully marked on the map');
    // Tambahkan logika untuk menambahkan marker toilet pada peta
  }

  // Fungsi untuk menangani perubahan navigasi di BottomNavigationBar
  void onBottomNavTapped(int index) {
    selectedIndex.value = index;
    // Tambahkan logika untuk berpindah halaman sesuai index
    if (index == 0) {
      Get.snackbar('Tab', 'Navigating to World tab');
    } else if (index == 1) {
      Get.snackbar('Tab', 'Navigating to Layers tab');
    } else if (index == 2) {
      Get.snackbar('Tab', 'Navigating to Profile tab');
    } else if (index == 3) {
      Get.snackbar('Tab', 'Navigating to Notifications tab');
    }
  }

  // Fungsi untuk mencari lokasi pengguna saat ini
  void findCurrentLocation() {
    Get.snackbar('Location', 'Finding current location...');
    // Tambahkan logika untuk mengambil lokasi pengguna
  }
}
