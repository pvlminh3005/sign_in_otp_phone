import 'package:get/get.dart';

import 'package:sign_up_phone/app/modules/home/bindings/home_binding.dart';
import 'package:sign_up_phone/app/modules/home/views/home_view.dart';
import 'package:sign_up_phone/app/modules/sign_up/bindings/sign_up_binding.dart';
import 'package:sign_up_phone/app/modules/sign_up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_UP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
  ];
}
