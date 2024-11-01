import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/newtoilet_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';
//import 'notifications_view.dart';

class NewToiletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewToiletController controller = Get.put(NewToiletController());
    final RxInt selectedIndex = 0.obs; // Untuk navigasi BottomNavigationBar

    return Scaffold(
      backgroundColor: Color(0xFF181C14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('New Toilet'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.saveToilet();
            },
            child: Text('Save', style: TextStyle(color: Colors.yellow)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Peta dan marker toilet
              Container(
                height: 200,
                color: Colors.grey,
                child: Center(child: Text('Map Placeholder with Toilet Marker')),
              ),
              SizedBox(height: 16),

              // Date & Time
              Text('Date & Time', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => controller.pickDateTime(),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(
                        () => Text(
                      controller.selectedDateTime.value,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Tag Location
              Text('Tag Location', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              TextField(
                controller: controller.tagLocationController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Tag Location',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Description
              Text('Description', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              TextField(
                controller: controller.descriptionController,
                style: TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Rating
              Text('How\'s the toilet?', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              RatingBar.builder(
                initialRating: controller.rating.value,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.yellow),
                onRatingUpdate: (rating) {
                  controller.rating.value = rating;
                },
              ),
              SizedBox(height: 16),

              // Photo selection
              Text('Toilet Photo', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo, color: Colors.white),
                    onPressed: () {
                      controller.pickImageFromGallery();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      controller.takePhoto();
                    },
                  ),
                  Obx(() => Text(
                    controller.selectedPhotoPath.value.isEmpty
                        ? 'No photo selected'
                        : controller.selectedPhotoPath.value,
                    style: TextStyle(color: Colors.white),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
