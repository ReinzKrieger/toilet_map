import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/profileedit_controller.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/UsernameEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/NameEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/BioEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/EmailEditView.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';

class ProfileEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileEditController controller = Get.put(ProfileEditController());

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stack untuk menampilkan gambar dan tombol edit
            Stack(
              alignment: Alignment.center,
              children: [
                // Lingkaran untuk foto profil
                Obx(
                      () => CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.profilePhoto.value.isNotEmpty
                        ? FileImage(controller.getImageFile()) // Gambar dari galeri/kamera
                        : null,
                    backgroundColor: Colors.grey,
                    child: controller.profilePhoto.value.isEmpty
                        ? Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      _showPhotoOptions(controller);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 16,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            // Bagian untuk mengedit Name
            _buildProfileOption(
              "Name",
              controller.name.value,
                  () {
                Get.to(() => NameEditView()); // Navigasi ke halaman edit name
              },
            ),
            Divider(color: Colors.grey),
            // Bagian untuk mengedit Username
            _buildProfileOption(
              "Username",
              controller.username.value,
                  () {
                Get.to(() => UsernameEditView()); // Navigasi ke halaman edit username
              },
            ),
            Divider(color: Colors.grey),
            // Bagian untuk mengedit Email
            _buildProfileOption(
              "Email",
              controller.email.value,
                  () {
                Get.to(() => EmailEditView()); // Navigasi ke halaman edit email
              },
            ),
            Divider(color: Colors.grey),
            // Bagian untuk mengedit Bio
            _buildProfileOption(
              "Bio",
              controller.bio.value,
                  () {
                Get.to(() => BioEditView()); // Navigasi ke halaman edit bio
              },
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }

  Widget _buildProfileOption(String title, String value, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(color: Colors.grey),
          ),
          Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showPhotoOptions(ProfileEditController controller) {
    Get.bottomSheet(
      Container(
        color: Colors.black,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: Colors.white),
              title: Text('Gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                controller.pickImageFromGallery();
                Get.back(); // Tutup bottom sheet
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.white),
              title: Text('Camera', style: TextStyle(color: Colors.white)),
              onTap: () {
                controller.pickImageFromCamera();
                Get.back(); // Tutup bottom sheet
              },
            ),
          ],
        ),
      ),
    );
  }
}
