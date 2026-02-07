import 'package:get/get.dart';
import 'package:university_finder_app/modules/auth/auth_controller.dart';
import 'package:university_finder_app/data/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

