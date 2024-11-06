import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toiletmap/app/modules/home/models/map_model.dart';
import 'package:toiletmap/app/modules/home/models/user_model.dart';

class UserWithMarkers {
  final UserList user;
  final List<MapModel> markers;
  UserWithMarkers({required this.user, required this.markers});
}

class FeedController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<UserWithMarkers> userWithMarkersList = <UserWithMarkers>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<Marker> markers = {};
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchMarkUserList();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchMarkUserList();
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

        fetchedUserWithMarkersList
            .add(UserWithMarkers(user: user, markers: markers));

        // Debug print each user and their markers
        print("User: ${user.email}, Markers Count: ${markers.length}");
      }

      userWithMarkersList.value = fetchedUserWithMarkersList;
      print("Total Users in Feed: ${userWithMarkersList.length}");
    } catch (e) {
      print("Error fetching users and markers: $e");
    }
  }

  void fetchMarkUserList() async {
    try {
      var markerDocs = await firebaseFirestore.collection('LocationMark').get();
      var userDocs = await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();

      List<UserWithMarkers> fetchedUserWithMarkersList = [];

      for (var markDoc in markerDocs.docs) {
        var user = await firebaseFirestore
            .collection('users')
            .doc(markDoc['userId'])
            .get();

        List<UserList> userlist = markerDocs.docs
            .map((doc) => UserList.fromJson(doc.data(), doc.id))
            .toList();

        List<MapModel> markers = markerDocs.docs
            .map((doc) => MapModel.fromMap(doc.id, doc.data()))
            .toList();

        fetchedUserWithMarkersList.add(UserWithMarkers(
          user: UserList.fromJson(user.data() ?? {}, user.id),
          markers: markers,
        ));

        print("fetchUser : $fetchedUserWithMarkersList");

        userWithMarkersList.assignAll(fetchedUserWithMarkersList);
      }
    } catch (e) {
      print("Error fetching users and markers: $e");
    }
  }

  Future<Set<Marker>> getMarkbyUid(String id) async {
    String uid = id;

    try {
      var markData =
          await firebaseFirestore.collection('LocationMark').doc(id).get();

      if (markData.exists) {
        var data = markData.data();
        latitude.value = data?['latitude'];
        longitude.value = data?['longitude'];

        if (data?['latitude'] != null && data?['longitude'] != null) {
          markers.add(
            Marker(
              markerId: MarkerId(id),
              position: LatLng(
                double.parse(data!['latitude'].toString()),
                double.parse(data['longitude'].toString()),
              ),
              infoWindow: InfoWindow(
                title: data['title'] ?? 'Unnamed Location',
              ),
            ),
          );
        }

        print("lat $latitude, long $longitude");
      }
    } catch (e) {
      print("error : $e");
    }

    return markers;
  }
}
