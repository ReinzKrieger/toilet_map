import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController {
  var users = [
    {'name': 'Atzee', 'image': null},
    {'name': 'Chester Bennington', 'image':null },
    {'name': 'Felix Lengyel', 'image':null },
    {'name': 'Mike Shinoda', 'image':null },
    {'name': 'Invreiz', 'image': null},
    {'name': 'Zexxed', 'image': null},
  ].obs;

  var selectedIndex = 2.obs; // Make this reactive using RxInt

  void onBottomNavTapped(int index) {
    selectedIndex.value = index;
    Get.snackbar('Tab Changed', 'Switched to tab $index');
  }
}