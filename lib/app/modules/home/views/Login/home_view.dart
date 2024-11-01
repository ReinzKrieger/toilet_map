import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:toiletmap/app/modules/home/controllers/auth_controller.dart';
import 'ForgotPasswordView.dart'; // Import the ForgotPasswordView
import 'SignUpView.dart'; // Import SignUpView

class LoginView extends StatelessWidget {
  final user = TextEditingController();
  final pass = TextEditingController();
  final authLogin = Get.find<AuthController>();

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181C14), // Adjust background color if needed
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: user,
              decoration: InputDecoration(
                hintText: 'Username / Email',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Obx(
              () => TextField(
                obscureText: !authLogin.isPasswordVisible.value,
                controller: pass,
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(authLogin.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: authLogin.togglePasswordVisibility,
                    )),
                onChanged: (value) => authLogin.password.value = value,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Navigate to ForgotPasswordView using GetX
                  Get.to(() => ForgotPasswordView());
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to MapPage using GetX when login button is pressed
                // Get.to(() => MapView());
                authLogin.login(user.text.trim(), pass.text.trim());
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
                'LOGIN',
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
                // Navigate to SignUpView using GetX
                Get.to(() => SignUpView());
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Or Login with',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _buildSocialButton('assets/google.png', () {
            //       // Add Google login action
            //     }),
            //     const SizedBox(width: 20),
            //     _buildSocialButton('assets/facebook.png', () {
            //       // Add Facebook login action
            //     }),
            //     const SizedBox(width: 20),
            //     _buildSocialButton('assets/x_icon.png', () {
            //       // Add Twitter login action
            //     }),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(asset),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
