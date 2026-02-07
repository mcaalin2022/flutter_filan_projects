
import 'package:get/get.dart';
import 'package:university_finder_app/modules/university/university_controller.dart';
import 'package:university_finder_app/data/repositories/university_repository.dart';

class UniversityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UniversityRepository>(() => UniversityRepository());
    Get.lazyPut<UniversityController>(() => UniversityController());
  }
}

