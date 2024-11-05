import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/models/map_model.dart';
import 'package:toiletmap/app/modules/home/models/user_model.dart';

// class FeedController extends GetxController {
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   Rxn<UserList?> firebaseUser = Rxn<UserList?>();
//   var userList = <UserList>[].obs;

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     fetchUser();
//   }

//   void fetchUser() async {
//     try {
//       var snapshot = await firebaseFirestore.collection('users').get();
//       if (kDebugMode) {
//         print("snapshot $snapshot");
//       }
//       userList.value = snapshot.docs
//           .map((doc) => UserList.fromJson(doc.data(), doc.id))
//           .toList();
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error $e");
//       }
//     }
//   }
// }

class UserWithMarkers {
  final UserList user;
  final List<MapModel> markers;

  UserWithMarkers({required this.user, required this.markers});
}

class FeedController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<UserWithMarkers> userWithMarkersList = <UserWithMarkers>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsersWithMarkers();
  }

 void fetchUsersWithMarkers() async {
  try {
    var userSnapshot = await firebaseFirestore.collection('users').get();

    List<UserWithMarkers> fetchedUserWithMarkersList = [];

    for (var userDoc in userSnapshot.docs) {
      UserList user = UserList.fromJson(userDoc.data(), userDoc.id);

      var markerSnapshot = await firebaseFirestore
          .collection('LocationMark')
          .where('userId', isEqualTo: user.id)
          .get();

      List<MapModel> markers = markerSnapshot.docs
          .map((doc) => MapModel.fromMap(doc.id, doc.data()))
          .toList();

      fetchedUserWithMarkersList.add(UserWithMarkers(user: user, markers: markers));

      // Debug print each user and their markers
      print("User: ${user.email}, Markers Count: ${markers.length}");
    }

    userWithMarkersList.value = fetchedUserWithMarkersList;
    print("Total Users in Feed: ${userWithMarkersList.length}");
  } catch (e) {
    print("Error fetching users and markers: $e");
  }
}
}
