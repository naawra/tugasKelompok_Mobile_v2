import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/arithmetic_controller.dart';
import '../../controllers/odd_even_prime_controller.dart';
import '../../controllers/char_counter_controller.dart';
import '../../controllers/stopwatch_controller.dart';
import '../../controllers/pyramid_controller.dart';

import '../../views/login/login_view.dart';
import '../../views/home/home_view.dart';
import '../../views/profile/profile_view.dart';
import '../../views/arithmetic/arithmetic_view.dart';
import '../../views/odd_even_prime/odd_even_prime_view.dart';
import '../../views/char_counter/char_counter_view.dart';
import '../../views/stopwatch/stopwatch_view.dart';
import '../../views/pyramid/pyramid_view.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthController())),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: AppRoutes.ARITHMETIC,
      page: () => const ArithmeticView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ArithmeticController())),
    ),
    GetPage(
      name: AppRoutes.ODD_EVEN_PRIME,
      page: () => const OddEvenPrimeView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OddEvenPrimeController())),
    ),
    GetPage(
      name: AppRoutes.CHAR_COUNTER,
      page: () => const CharCounterView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => CharCounterController())),
    ),
    GetPage(
      name: AppRoutes.STOPWATCH,
      page: () => const StopwatchView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => StopwatchController())),
    ),
    GetPage(
      name: AppRoutes.PYRAMID,
      page: () => const PyramidView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PyramidController())),
    ),
  ];
}
