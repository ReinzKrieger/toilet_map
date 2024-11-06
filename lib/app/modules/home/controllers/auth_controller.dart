import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toiletmap/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Reactive map to store user profile data
  var userData = {}.obs;

  // Handle Firebase User
  Stream<User?> get user => auth.authStateChanges();

  // Password Controller
  RxBool isPasswordVisible = false.obs;
  RxString password = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (auth.currentUser != null) {
      fetchUserData();
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void login(String users, String pass) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: users, password: pass);

      // Fetch user data after successful login
      await fetchUserData();
      Get.offNamed(Routes.profile);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Login Gagal", "User Tidak Ditemukan \n atau Password Salah");
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.home);
  }

  Future<void> signUp(
      String email, String password, String repeatPass, String username) async {
    if (password != repeatPass) {
      Get.snackbar("Oops", "Password Tidak Sesuai");
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user data to Firestore
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': username,
        'email': email,
      });

      // Fetch user data after sign up
      await fetchUserData();
      Get.offAllNamed(Routes.profile);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchUserData() async {
    try {
      if (auth.currentUser == null) {
        print("No authenticated user found.");
        return;
      }

      String uid = auth.currentUser!.uid;
      print("Fetching data for UID: $uid"); // Debug UID

      DocumentSnapshot userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        print("User document data: ${userDoc.data()}"); // Debug document data
        userData.value = userDoc.data() as Map<String, dynamic>;
      } else {
        print("No user document found for UID: $uid");
        Get.snackbar('Error', 'No user data found');
      }
    } catch (e) {
      print("Error fetching user data: $e");
      Get.snackbar('Error', 'Failed to fetch user data');
    }
  }

  Future<void> requestLocation() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
  }
}
