import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181C14), // Adjust background color if needed
      appBar: AppBar(
        backgroundColor: Color(0xFF181C14),
        automaticallyImplyLeading: true, // Adds back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Back to the Forgot Password page
          },
        ),
        title: const Text('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '', // Hide character counter
                    ),
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    keyboardType: TextInputType.number,
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the verification code we just sent to your email address',
              style: TextStyle(color: Colors.white54, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add verify action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700], // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'VERIFY',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Add resend email action here
              },
              child: RichText(
                text: const TextSpan(
                  text: 'If you didn\'t receive the code, ',
                  style: TextStyle(color: Colors.white54),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Resend Email',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
