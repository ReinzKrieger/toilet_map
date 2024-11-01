import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/views/MapMenu/mapglobal_view.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/profile_view.dart';
import 'package:toiletmap/app/modules/home/controllers/bottomnav_controller.dart'; // Import controller
import 'package:toiletmap/app/modules/home/views/InboxMenu/inbox_view.dart';
import 'package:toiletmap/app/modules/home/views/FeedMenu/Feedview.dart';
class CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.find<BottomNavController>();

    return Obx(
          () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: bottomNavController.selectedIndex.value,
        onTap: (index) {
          bottomNavController.changeIndex(index); // Perbarui selectedIndex
          if (index == 0) {
            Get.to(MapView()); // Navigasi ke halaman Map
          } else if (index == 1) {
            Get.to(FeedView()); // Navigasi ke halaman Profile
          } else if (index == 2) {
            Get.to(ProfileView()); // Navigasi ke halaman Profile
          } else if (index == 3){
            Get.to(NotificationsView());
          }
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: bottomNavController.selectedIndex.value == 0
                ? Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(Icons.language, color: Colors.black),
            )
                : Icon(Icons.language),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: bottomNavController.selectedIndex.value == 1
                ? Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(Icons.layers, color: Colors.black),
            )
                : Icon(Icons.layers),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: bottomNavController.selectedIndex.value == 2
                ? Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(Icons.person, color: Colors.black),
            )
                : Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: bottomNavController.selectedIndex.value == 3
                ? Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(Icons.notifications, color: Colors.black),
            )
                : Icon(Icons.notifications),
            label: '',
          ),
        ],
      ),
    );
  }
}
