import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:toiletmap/app/modules/home/models/map_model.dart';

class MapController extends GetxController {
  var selectedIndex = 0.obs; // Untuk BottomNavigationBar
  var selectedMapType = 0.obs; // Untuk peta (Global, Friends, Individual)
  var mapMarkers = <MapModel>[].obs;

  final Location location = Location();

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
    print("Map type changed to: ${selectedMapType.value}");
    fetchMarkers();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMarkers(); // Fetch markers from Firebase on init
  }

  void fetchMarkers() async {
    final userId =
        FirebaseAuth.instance.currentUser?.uid; // Get the logged-in user's ID
    print("Current User ID: $userId");
    FirebaseFirestore.instance
        .collection('LocationMark')
        .snapshots()
        .listen((snapshot) {
      mapMarkers.clear();

      for (var doc in snapshot.docs) {
        final marker = MapModel.fromMap(doc.id, doc.data());
        print("Loaded Marker: ${marker.title}, User ID: ${marker.userId}");

        // Add markers based on selectedMapType
        if (selectedMapType.value == 0) {
          // Global view: show all markers
          mapMarkers.add(marker);
        } else if (selectedMapType.value == 2 && marker.userId == userId) {
          // Individual view: show only markers associated with the logged-in user
          mapMarkers.add(marker);
        }
      }

      mapMarkers.refresh(); // Refresh to trigger Obx update
      print("Total markers after fetch: ${mapMarkers.length}");
    });
  }

  Widget buildMap() {
    List<MapModel> filteredMarkers = [];

    if (selectedMapType.value == 0) {
      // Global view: show all markers
      filteredMarkers = mapMarkers;
      print("Global View - Total Markers: ${filteredMarkers.length}");
    } else if (selectedMapType.value == 1) {
      // Individual view: show only markers associated with the logged-in user
      final userId = FirebaseAuth.instance.currentUser?.uid;
      print("Filtering markers for User ID: $userId");

      filteredMarkers = mapMarkers.where((marker) {
        print(
            "Checking Marker User ID: ${marker.userId}, Title: ${marker.title}");
        return marker.userId == userId;
      }).toList();

      print(
          "Individual View - Markers for User ID $userId: ${filteredMarkers.length}");
    }

    return Container(
      color: Colors.greenAccent,
      child: Column(
        children: [
          Text(
            'Showing ${selectedMapType.value == 0 ? "Global" : "Individual"} Map',
          ),
          ...filteredMarkers.map((marker) => ListTile(
                title: Text(
                    '${marker.title} at ${marker.latitude}, ${marker.longitude}'),
                subtitle: Text(marker.description),
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
