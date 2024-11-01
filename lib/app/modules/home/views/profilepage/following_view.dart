import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/following_controller.dart';
import 'package:toiletmap/app/modules/home/views/custom_bottom_nav.dart';

class FollowingView extends GetView<FollowingController> {
  @override
  Widget build(BuildContext context) {
    final FollowingController controller = Get.put(FollowingController());

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Users you follow',
          style: TextStyle(color: Colors.white),),

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          final user = controller.users[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: user['image'] != null
                  ? NetworkImage(user['image']!)
                  : null,
              backgroundColor: Colors.grey,
            ),
            title: Text(
              user['name']!,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
        },
      )),
      bottomNavigationBar: CustomBottomNav(),
    );
  }

  // Build each navigation item with a custom look

  }
