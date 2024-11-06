// lib/views/toilet_detail_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toiletmap/app/modules/home/controllers/feed_controller.dart';

class ToiletDetailView extends StatelessWidget {
  FeedController feedController = Get.put(FeedController());

  ToiletDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    // Retrieve the user’s name and marker location data from arguments
    final String userName = Get.arguments['name'] ?? 'User';
    var id = Get.arguments['id'] ?? 0;
    print(id);
    final dynamic locationArg = Get.arguments['location'];
    final LatLng defaultLocation = LatLng(-6.992049, 110.417739);

    final LatLng location =
        (locationArg != null && locationArg != "" && locationArg is LatLng)
            ? locationArg
            : defaultLocation;
    // Hardcoded comments for the demo
    final List<Map<String, String>> comments = [
      {"user": "Alice", "comment": "Clean and well-maintained."},
      {"user": "Bob", "comment": "Great location and accessible."},
      {"user": "Charlie", "comment": "Needs more facilities nearby."},
    ];
    feedController.getMarkbyUid(id);
    return Scaffold(
      backgroundColor: Color(0xFF181C14),
      appBar: AppBar(
        title:
            Text("$userName's Toilet", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
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
          // Display Google Map with marker
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: FutureBuilder<Set<Marker>>(
                future: feedController.getMarkbyUid(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.yellow),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading markers: ${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(feedController.latitude.value,
                          feedController.longitude.value),
                      zoom: 15,
                    ),
                    markers: snapshot.data ?? {},
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                  );
                }),
          ),
          SizedBox(height: 10),

          // Hardcoded comments section
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(comment['user']!,
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(comment['comment']!,
                      style: TextStyle(color: Colors.grey)),
                );
              },
            ),
          ),

          // Comment input field
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
                  icon: Icon(Icons.camera_alt,
                      color: const Color.fromARGB(255, 41, 33, 33)),
                  onPressed: () {
                    // Action for camera or attachment
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.yellow),
                  onPressed: () {
                    // Action for sending comment (not implemented)
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
