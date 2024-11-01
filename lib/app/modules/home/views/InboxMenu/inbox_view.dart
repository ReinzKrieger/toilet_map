// lib/views/notifications_view.dart
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';

class NotificationsView extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "name": "Invreiz",
      "message": "is now following you",
      "time": "23 hours ago",
    },
    {
      "name": "Atzaa",
      "message": "is following you back",
      "time": "25/06/2024",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black, // Black background for AppBar
        elevation: 0, // Remove shadow
        automaticallyImplyLeading: false, // Hilangkan back button
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: notification['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' ${notification['message']}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            trailing: Text(
              notification['time']!,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}