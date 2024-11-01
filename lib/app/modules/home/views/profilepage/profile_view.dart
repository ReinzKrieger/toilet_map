import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              // Aksi QR Code
              Get.snackbar('QR Code', 'QR Code pressed');
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: Colors.white),
          //   onPressed: () {
          //     // Aksi untuk opsi lainnya
          //     // Get.snackbar('More', 'More options pressed');

          //   },
          // ),
          PopupMenuButton<void Function()>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: () => authUser.logout(), child: const Text('Logout'))
              ];
            },
            onSelected: (fn) => fn(),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bagian foto profil dan nama
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://placehold.co/100x100'), // Placeholder image
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Member Since:',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Tombol Edit Profile dan Add Friend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ProfileEditView());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.yellow[600], // Warna teks
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
                    backgroundColor: Colors.yellow[600], // Warna teks
                  ),
                  child: Text('Add Friend'),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Box panjang untuk Toilet Marked dengan navigasi ke ToiletMarkedView
            GestureDetector(
              // onTap: () {
              //   Get.to(() => ToiletMarkedView());
              // },
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
                          '11',
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
            // Box gabungan untuk States, Countries, Continents dengan navigasi ke RegionView
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
                    _buildStatItem('4', 'States', Colors.cyan),
                    _buildStatItem('2', 'Countries', Colors.blue),
                    _buildStatItem('1', 'Continents', Colors.purple),
                  ],
                ),
              ),
            ),
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
