import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/profile_controller.dart'; // Import controller
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';

class NameEditView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Navigasi kembali
          },
        ),
        title: Text(
          'Name',
          style: TextStyle(color: Colors.white), // Warna teks kuning
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.saveProfile('name'); // Aksi ketika tombol Done ditekan
            },
            child: Text(
              'Done',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ],
        backgroundColor: Colors.black, // Latar belakang hitam di AppBar
        elevation: 0, // Hilangkan bayangan di AppBar agar lebih bersih
      ),
      body: SingleChildScrollView(
        // Menambahkan scroll untuk mencegah overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.nameTextController,
              maxLength: 50, // Maksimal 50 karakter
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Colors.black54, // Warna background TextField abu-abu gelap
                hintText: 'Add your name',
                hintStyle: TextStyle(color: Colors.white), // Placeholder kuning
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade700, // Border abu-abu
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.white, // Border kuning saat fokus
                    width: 2,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.white), // Teks input putih
              maxLines: 1,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Obx(() => Text(
                    '${controller.name.value.length}/50', // Menampilkan hitungan karakter
                    style: TextStyle(color: Colors.grey),
                  )),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black12, // Latar belakang hitam seluruh body
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
