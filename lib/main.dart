import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/auth_controller.dart';
import 'package:toiletmap/app/utils/loading.dart';
import 'app/routes/app_pages.dart'; // Import AppPages untuk routing
import 'package:toiletmap/app/modules/home/controllers/bottomnav_controller.dart'; // Import BottomNavController

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final authenticate = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authenticate.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (kDebugMode) {
              print(snapshot.data);
            }

            return GetMaterialApp(
              title: "Application",
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data != null
                  ? Routes.profile
                  : Routes.home, // Rute awal aplikasi
              getPages: AppPages
                  .routes, // Daftar halaman yang bisa diakses melalui rute
              initialBinding: BindingsBuilder(() {
                Get.put(
                    BottomNavController()); // Inisialisasi BottomNavController di sini
              }),
            );
          } else {
            return LoadingView();
          }
        });
  }
}
