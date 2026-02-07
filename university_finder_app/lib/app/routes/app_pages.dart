
import 'package:get/get.dart';
import 'package:university_finder_app/modules/splash/splash_view.dart';
import 'package:university_finder_app/modules/splash/splash_controller.dart';
import 'package:university_finder_app/modules/auth/login_view.dart';
import 'package:university_finder_app/modules/auth/register_view.dart';
import 'package:university_finder_app/app/bindings/auth_binding.dart';
import 'package:university_finder_app/modules/university/university_list_view.dart';
import 'package:university_finder_app/modules/university/university_detail_view.dart';
import 'package:university_finder_app/app/bindings/university_binding.dart';
import 'package:university_finder_app/modules/search/search_view.dart';
import 'package:university_finder_app/modules/search/search_controller.dart';
import 'package:university_finder_app/modules/program/program_view.dart';
import 'package:university_finder_app/modules/program/program_controller.dart';
import 'package:university_finder_app/modules/profile/profile_setup_view.dart';
import 'package:university_finder_app/modules/university/application_view.dart';
import 'package:university_finder_app/modules/university/application_controller.dart';
import 'package:university_finder_app/modules/profile/profile_view.dart';
import 'package:university_finder_app/modules/profile/profile_controller.dart';
import 'package:university_finder_app/modules/auth/forgot_password_view.dart';
import 'package:university_finder_app/modules/admin/admin_dashboard_view.dart';
import 'package:university_finder_app/modules/admin/admin_dashboard_controller.dart';
import 'package:university_finder_app/modules/home/main_view.dart';
import 'package:university_finder_app/app/bindings/main_binding.dart';
import 'package:university_finder_app/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.UNIVERSITY_LIST,
      page: () => const UniversityListView(),
      binding: UniversityBinding(),
    ),
    GetPage(
      name: Routes.UNIVERSITY_DETAIL,
      page: () => const UniversityDetailView(),
      binding: UniversityBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SearchController());
      }),
    ),
    GetPage(
      name: Routes.PROGRAM,
      page: () => const ProgramView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProgramController());
      }),
    ),
    GetPage(
      name: Routes.PROFILE_SETUP,
      page: () => const ProfileSetupView(),
    ),
    GetPage(
      name: Routes.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AdminDashboardController());
      }),
    ),
    GetPage(
      name: Routes.APPLY,
      page: () => const ApplicationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ApplicationController());
      }),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: AuthBinding(),
    ),
  ];
}
