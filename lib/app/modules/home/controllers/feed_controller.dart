import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/models/user_model.dart';

class FeedController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Rxn<UserList?> firebaseUser = Rxn<UserList?>();
  var userList = <UserList>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async {
    try {
      var snapshot = await firebaseFirestore.collection('users').get();
      if (kDebugMode) {
        print("snapshot $snapshot");
      }
      userList.value = snapshot.docs
          .map((doc) => UserList.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    }
  }
}
