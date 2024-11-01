import 'package:get/get.dart';

import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/NameEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/BioEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/EmailEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/ProfileEdit/UsernameEditView.dart';
import 'package:toiletmap/app/modules/home/views/profilepage/profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/Login/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => LoginView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.profile,
        page: () => ProfileView(),
        binding: HomeBinding()),
    GetPage(
      name: '/edit-name',
      page: () => NameEditView(),
    ),
    GetPage(
      name: '/edit-username',
      page: () => UsernameEditView(),
    ),
    GetPage(
      name: '/edit-email',
      page: () => EmailEditView(),
    ),
    GetPage(
      name: '/edit-bio',
      page: () => BioEditView(),
    ),
  ];
}
