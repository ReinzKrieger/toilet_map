import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181C14), // Background color
      appBar: AppBar(
        title: const Text('Feed'),
        backgroundColor: Color(0xFF181C14), // Same background as body
        actions: [
          TextButton(
            onPressed: () {
              // Handle add friends action
            },
            child: Text(
              'Add Friends',
              style: TextStyle(color: Colors.yellow), // Yellow text for Add Friends
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 100,
              color: Colors.white, // White color for icon
            ),
            const SizedBox(height: 20),
            Text(
              'Empty Feed',
              style: TextStyle(color: Colors.white, fontSize: 24), // White large text
            ),
            const SizedBox(height: 10),
            // Text(
            //   'Mark Toilet on the map or follow people to see the feed',
            //   style: TextStyle(color: Colors.white54), // White faded text
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
