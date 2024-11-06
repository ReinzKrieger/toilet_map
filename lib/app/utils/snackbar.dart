// Contoh Custom Snackbar Utility
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtil {
  static void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error_outline, color: Colors.white),
      shouldIconPulse: true,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Text('OK', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static void showWarning(String message) {
    Get.snackbar(
      'Warning',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  static void showInfo(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.info_outline, color: Colors.white),
    );
  }
}
