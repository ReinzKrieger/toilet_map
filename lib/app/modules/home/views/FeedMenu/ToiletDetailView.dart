// lib/views/toilet_detail_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToiletDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil nama pengguna dari arguments yang dikirim dari FeedView
    final String userName = Get.arguments['name'] ?? 'User';

    return Scaffold(
      backgroundColor: Color(0xFF181C14), // Set background color
      appBar: AppBar(
        title: Text("$userName's Toilet", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0, // Remove shadow
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed('/profilePage'); // Navigate to Profile
            },
            child: Text('Profile', style: TextStyle(color: Colors.yellow)),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Navigate back to previous page
          },
        ),
      ),
      body: Column(
        children: [
          // Map placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                'Map Placeholder',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Text(
                'There are no comments on this toilet yet',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    // Action for camera or attachment
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.yellow),
                  onPressed: () {
                    // Action for sending comment
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
