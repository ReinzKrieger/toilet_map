import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/region_controller.dart';
// Import ProfileView jika perlu navigasi kembali
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';
class RegionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegionController controller = Get.put(RegionController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Toilet Locations', style: TextStyle (
            color: Colors.white
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow with white color
          onPressed: () {
            // Navigasi kembali ke ProfileView menggunakan Get.back()
            Get.back(); // Akan kembali ke halaman sebelumnya, yaitu ProfileView
          },
        ),
      ),
      body: Column(
        children: [
          // Tab buttons for switching between categories
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton(controller, 'States', 0),
                _buildTabButton(controller, 'Countries', 1),
                _buildTabButton(controller, 'Continents', 2),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.locations.length,
              itemBuilder: (context, index) {
                final location = controller.locations[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    location['name'] as String,  // Explicitly cast to String
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Last mark : ${location['lastMark'] as String}', // Explicitly cast to String
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        location['toilets'].toString(),
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Toilets',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    controller.onLocationTapped(location['name'] as String);  // Explicitly cast to String
                  },
                );
              },
            )),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }

  // Tab button builder
  Widget _buildTabButton(RegionController controller, String label, int index) {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.onTabChanged(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: controller.selectedTab == index ? Colors.grey : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: controller.selectedTab == index ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
