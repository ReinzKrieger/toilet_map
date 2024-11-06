// lib/views/feed_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/feed_controller.dart';
import 'package:toiletmap/app/modules/home/views/FeedMenu/ToiletDetailView.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';

import 'add_friends_view.dart';

class FeedView extends StatelessWidget {
  FeedController feedController = Get.put(FeedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181C14),
      appBar: AppBar(
        title: Text('Feed', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false, // Remove back button
        actions: [
          TextButton(
            onPressed: () {
              Get.to(AddFriendsView()); // Navigate to Add Friends Page
            },
            child: Text('Add Friends', style: TextStyle(color: Colors.yellow)),
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: feedController.userWithMarkersList.length,
                itemBuilder: (context, index) {
                  final userWithMarkers =
                      feedController.userWithMarkersList[index];

                  return Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              // Navigate to ToiletDetailView with user name as argument
                              Get.to(() => ToiletDetailView(), arguments: {
                                'name': userWithMarkers.user.name,
                                'id': userWithMarkers.markers[index].id
                              });
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[800],
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(userWithMarkers.user.name ?? "Unkown",
                                style: TextStyle(color: Colors.white)),
                            subtitle: Row(
                              children: [
                                // Icon(Icons.star,
                                //     color: Colors.yellow, size: 16),
                                // Icon(Icons.star,
                                //     color: Colors.yellow, size: 16),
                                // Icon(Icons.star,
                                //     color: Colors.yellow, size: 16),
                                RatingBar.builder(
                                  initialRating:
                                      userWithMarkers.markers[index].rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.yellow),
                                  onRatingUpdate: (rating) {},
                                  ignoreGestures: true,
                                ),
                              ],
                            ),
                          ),
                          // // Display markers for each user below their profile
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: userWithMarkers.markers.map((marker) {
                          //     return ListTile(
                          //       leading: Icon(Icons.location_on,
                          //           color: Colors.yellow),
                          //       title: Text(marker.title,
                          //           style: TextStyle(color: Colors.white)),
                          //       subtitle: Text(
                          //         '${marker.latitude}, ${marker.longitude}',
                          //         style: TextStyle(color: Colors.grey),
                          //       ),
                          //     );
                          //   }).toList(),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
