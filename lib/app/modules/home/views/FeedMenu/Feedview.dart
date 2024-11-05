// lib/views/feed_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/feed_controller.dart';
import 'package:toiletmap/app/modules/home/views/FeedMenu/ToiletDetailView.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';

import 'add_friends_view.dart';

class FeedView extends StatelessWidget {
  FeedController feedController = Get.put(FeedController());
  // final List<Map<String, String>> feedData = [
  //   {
  //     "name": "Atzaa",
  //     "date": "08/10/2023 17:22",
  //     "rating": "1",
  //   },
  //   {
  //     "name": "Invreiz",
  //     "date": "07/10/2023 23:36",
  //     "rating": "2",
  //   },
  //   {
  //     "name": "John Doe",
  //     "date": "11/12/2023 19:48",
  //     "rating": "3",
  //   },
  //   {
  //     "name": "John Doe",
  //     "date": "11/12/2023 19:48",
  //     "rating": "2",
  //   }
  // ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Color(0xFF181C14), // Set background color as in the screenshot
//       appBar: AppBar(
//         title: Text('Feed', style: TextStyle(color: Colors.white)),
//         automaticallyImplyLeading: false, // Remove back button
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.to(AddFriendsView()); // Navigate to Add Friends Page
//             },
//             child: Text('Add Friends', style: TextStyle(color: Colors.yellow)),
//           ),
//         ],
//         backgroundColor: Colors.black, // Black background for AppBar
//         elevation: 0, // Remove shadow
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 itemCount: feedController.userList.length,
//                 itemBuilder: (context, index) {
//                   final item = feedController.userList[index];
//                   return ListTile(
//                     onTap: () {
//                       // Navigasi ke ToiletDetailView dengan mengirim nama pengguna
//                       Get.to(() => ToiletDetailView(), arguments: {
//                         'name': item.name,
//                       });
//                     },
//                     leading: CircleAvatar(
//                       backgroundColor:
//                           Colors.grey[800], // Placeholder for profile picture
//                       child: Icon(Icons.person, color: Colors.white),
//                     ),
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.name ?? '',
//                                 style: TextStyle(color: Colors.white)),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Icon(Icons.star,
//                                     color: Colors.yellow, size: 16),
//                                 Icon(Icons.star,
//                                     color: Colors.yellow, size: 16),
//                                 Icon(Icons.star,
//                                     color: Colors.yellow, size: 16),
//                               ],
//                             ),
//                           ],
//                         ),
//                         // Text(item['date'] ?? '',
//                         //     style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//       bottomNavigationBar:
//           CustomBottomNav(), // Keep the custom bottom navigation
//     );
//   }
// }
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
                final userWithMarkers = feedController.userWithMarkersList[index];

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
                              'name': userWithMarkers.user.email,
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[800],
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(userWithMarkers.user.email,
                              style: TextStyle(color: Colors.white)),
                          subtitle: Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                            ],
                          ),
                        ),
                        // Display markers for each user below their profile
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: userWithMarkers.markers.map((marker) {
                            return ListTile(
                              leading: Icon(Icons.location_on,
                                  color: Colors.yellow),
                              title: Text(marker.title,
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(
                                '${marker.latitude}, ${marker.longitude}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }).toList(),
                        ),
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
