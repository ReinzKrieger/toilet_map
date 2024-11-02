import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toiletmap/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // Handle Firebase User
  Stream<User?> get user => auth.authStateChanges();

  // Password Controller
  RxBool isPasswordVisible = false.obs;
  RxString password = ''.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void login(String users, String pass) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: users, password: pass);
      Get.offNamed(Routes.map);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Login Gagal", "User Tidak Ditemukan \n atau Password Salah");
      // if (e.code == 'user-not-found') {
      //   print("Users Not Found");
      // } else if (e.code == 'wrong-password') {
      //   print("Wrong Password");
      // }
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
      Get.offAllNamed(Routes.profile);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> requestLocation() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
  }
}
