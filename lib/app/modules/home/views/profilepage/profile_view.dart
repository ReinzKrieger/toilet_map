import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/modules/home/controllers/auth_controller.dart';
import 'region_view.dart'; // Import RegionView untuk navigasi
//import '../profilepage/ToiletMarkedView'; // Import ToiletMarkedView untuk navigasi
import 'following_view.dart'; // Import FollowingView untuk navigasi
import 'followers_view.dart'; // Import FollowersView untuk navigasi
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/profileedit_view.dart';
import 'package:toiletmap/app/modules/home/views/FeedMenu/add_friends_view.dart';

class ProfileView extends StatelessWidget {
  final authUser = Get.find<AuthController>();
  String formattedDate = DateFormat('dd/mm/yyyy').format(DateTime.now());
  // String formatDate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181C14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code, color: Colors.white),
            onPressed: () {
              Get.snackbar('QR Code', 'QR Code pressed');
            },
          ),
          PopupMenuButton<void Function()>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: () => authUser.logout(),
                    child: const Text('Logout')),
              ];
            },
            onSelected: (fn) => fn(),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile picture and name section
              Obx(() {
                final userData = authUser.userData;
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        userData['photoUrl'] ?? 'https://placehold.co/100x100',
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['name'] ?? 'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Member Since: $formattedDate',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              SizedBox(height: 16),
              // Edit Profile and Add Friend buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ProfileEditView());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow[600],
                    ),
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => AddFriendsView());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow[600],
                    ),
                    child: Text('Add Friend'),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Toilet Marked section
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.tag, color: Colors.red),
                          SizedBox(height: 8),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${authUser.userData['toiletsMarked'] ?? '0'}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Toilets Marked',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // States, Countries, Continents section
              GestureDetector(
                onTap: () {
                  Get.to(() => RegionView());
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('${authUser.userData['states'] ?? '0'}',
                          'States', Colors.cyan),
                      _buildStatItem('${authUser.userData['countries'] ?? '0'}',
                          'Countries', Colors.blue),
                      _buildStatItem(
                          '${authUser.userData['continents'] ?? '0'}',
                          'Continents',
                          Colors.purple),
                    ],
                  ),
                ),
              ),
              // Additional UI sections (Following, Followers, Settings)
              // Remaining code unchanged
              SizedBox(height: 16),
              // Box untuk Following dan Followers yang ukurannya sama dengan Toilets Marked
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Box untuk Following dengan navigasi ke FollowingView
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => FollowingView());
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.pink),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.group, color: Colors.pink),
                            SizedBox(height: 8),
                            Text(
                              '6',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Box untuk Followers dengan navigasi ke FollowersView
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => FollowersView());
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.people, color: Colors.green),
                            SizedBox(height: 8),
                            Text(
                              '3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Settings
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings', style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  Get.snackbar('Settings', 'Navigating to Settings');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }

  Widget _buildStatItem(String count, String label, Color color) {
    return Column(
      children: [
        Icon(Icons.public, color: color),
        SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
