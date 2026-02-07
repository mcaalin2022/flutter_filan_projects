import 'package:get/get.dart';
import 'package:university_finder_app/modules/home/home_controller.dart';
import 'package:university_finder_app/modules/home/main_controller.dart';
import 'package:university_finder_app/modules/search/search_controller.dart';
import 'package:university_finder_app/modules/university/saved_controller.dart';
import 'package:university_finder_app/modules/profile/profile_controller.dart';
import 'package:university_finder_app/data/repositories/university_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UniversityRepository());
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => SavedController());
    Get.lazyPut(() => ProfileController());
  }
}
