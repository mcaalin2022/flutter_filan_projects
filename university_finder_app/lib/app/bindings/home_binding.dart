import 'package:get/get.dart';
import 'package:university_finder_app/modules/home/home_controller.dart';
import 'package:university_finder_app/data/repositories/university_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UniversityRepository>(() => UniversityRepository());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

