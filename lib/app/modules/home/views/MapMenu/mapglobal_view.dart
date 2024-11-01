import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/map_controller.dart';
import 'package:toiletmap/app/modules/home/views/MapMenu/newtoilet_view.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';
class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MapController controller = Get.put(MapController());

    return Scaffold(
      backgroundColor: Color(0xFF181C14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Map', style: TextStyle (
            color: Colors.white
        ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Map area (gunakan widget peta sesuai kebutuhan, misalnya Google Maps atau Leaflet)
          Obx(() => controller.buildMap()),

          // Tombol untuk memilih peta (Global, Friends, Individual)
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMapTypeButton(controller, 'Global', 0, Icons.language),
                _buildMapTypeButton(controller, 'Friends', 1, Icons.group),
                _buildMapTypeButton(controller, 'Individual', 2, Icons.person),
              ],
            ),
          ),

          // Tombol Mark the toilet di tengah bagian bawah layar
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => NewToiletView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Mark the toilet', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(), // Gunakan widget Bottom Nav
    );
  }

  Widget _buildMapTypeButton(MapController controller, String label, int index, IconData icon) {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.onMapTypeChanged(index),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: controller.selectedMapType.value == index ? Colors.yellow : Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: controller.selectedMapType.value == index ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
