// lib/views/add_friends_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'qr_code_view.dart'; // Import QRCodeView
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';
class AddFriendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181C14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text('Add Friends', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("Invreiz's", style: TextStyle(color: Colors.white)),
              subtitle: Text("now 17 hours ago", style: TextStyle(color: Colors.grey)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Action when tapped
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Invudin", style: TextStyle(color: Colors.white)),
              subtitle: Text("1 days ago", style: TextStyle(color: Colors.grey)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Action when tapped
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(Icons.qr_code, color: Colors.black),
        onPressed: () {
          Get.to(() => QRCodeView()); // Navigate to QR Code View
        },
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
