
import 'package:get/get.dart';
import 'package:university_finder_app/data/models/university_model.dart';
import 'package:university_finder_app/data/repositories/university_repository.dart';

class UniversityController extends GetxController {
  final UniversityRepository _repository = Get.find<UniversityRepository>();

  final universities = <UniversityModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    isLoading.value = true;
    try {
      final result = await _repository.getUniversities();
      universities.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}

