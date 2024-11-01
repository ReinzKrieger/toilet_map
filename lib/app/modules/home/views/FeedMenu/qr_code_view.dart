// lib/views/qr_code_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QRCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color
      appBar: AppBar(
        title: Text('QR CODE', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simulasi Gambar QR Code
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: Icon(Icons.qr_code, size: 150, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              'Scan the QR Code',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
