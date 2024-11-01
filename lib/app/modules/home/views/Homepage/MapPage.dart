// import 'package:flutter/material.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   int _selectedIndex = 0;
//
//   // Define the pages for navigation
//   final List<Widget> _pages = [
//     MapView(), // Map page
//     // Notification page
//   ];
//
//   // Function to handle navigation when an icon is tapped
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Display the currently selected page
//           _pages[_selectedIndex],
//           // Top Bar with Icons (Globe, People, Gear)
//           Positioned(
//             top: 40, // Adjust the position as needed
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildTopButton(Icons.public, true), // Active (Yellow) button
//                   const SizedBox(width: 10),
//                   _buildTopButton(Icons.group, false),
//                   const SizedBox(width: 10),
//                   _buildTopButton(Icons.person_outline, false)
//                 ],
//               ),
//             ),
//           ),
//           // Positioned Floating Button
//           Positioned(
//             bottom: 100,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.yellow[700], // Button color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 15,
//                   ),
//                 ),
//                 onPressed: () {
//                   // Handle "Mark the toilet" action
//                 },
//                 child: const Text(
//                   'Mark the toilet',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.black,
//         selectedItemColor: Colors.yellow[700],
//         unselectedItemColor: Colors.white,
//         currentIndex: _selectedIndex, // Set the currently selected index
//         onTap: _onItemTapped, // Handle tap on navigation bar items
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message), // Feed Icon
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications), // Notification icon
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper method to build top buttons
//   Widget _buildTopButton(IconData icon, bool isActive) {
//     return ElevatedButton(
//       onPressed: () {
//         // Handle button press action here
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isActive ? Colors.yellow[700] : Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         padding: const EdgeInsets.all(10),
//       ),
//       child: Icon(
//         icon,
//         color: isActive ? Colors.black : Colors.white,
//       ),
//     );
//   }
// }
//
// // Placeholder for the MapView page
// class MapView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Map View',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }
