import 'package:get/get.dart';

class RegionController extends GetxController {
  var locations = [
    {'name': 'Indonesia', 'lastMark': 'Today', 'toilets': 9},
    {'name': 'Malaysia', 'lastMark': '1/5/2024', 'toilets': 2},
  ].obs;

  var selectedIndex = 2.obs; // Bottom navigation index
  var selectedTab = 1.obs; // Default selected tab (Countries)

  void onBottomNavTapped(int index) {
    selectedIndex.value = index;
    update();
  }

  void onTabChanged(int index) {
    selectedTab.value = index;
    update();

    // Logic to load data based on tab selection
    if (index == 0) {
      locations.value = [
        {'name': 'California', 'lastMark': 'Yesterday', 'toilets': 5},
        {'name': 'New York', 'lastMark': '2/3/2024', 'toilets': 3},
      ];
    } else if (index == 1) {
      locations.value = [
        {'name': 'Indonesia', 'lastMark': 'Today', 'toilets': 9},
        {'name': 'Malaysia', 'lastMark': '1/5/2024', 'toilets': 2},
      ];
    } else if (index == 2) {
      locations.value = [
        {'name': 'Asia', 'lastMark': 'Today', 'toilets': 15},
        {'name': 'Europe', 'lastMark': '3/5/2024', 'toilets': 10},
      ];
    }
  }

  void onLocationTapped(String name) {
    // Handle tap on location
    Get.snackbar('Location Tapped', 'You tapped on $name');
  }
}
