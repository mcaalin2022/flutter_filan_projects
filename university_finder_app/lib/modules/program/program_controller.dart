import 'package:get/get.dart';
import 'package:university_finder_app/data/models/program_model.dart';
import 'package:university_finder_app/data/repositories/program_repository.dart';

class ProgramController extends GetxController {
  final ProgramRepository _repository = Get.find<ProgramRepository>();

  final programs = <ProgramModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    isLoading.value = true;
    try {
      final result = await _repository.getAllPrograms();
      programs.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}

