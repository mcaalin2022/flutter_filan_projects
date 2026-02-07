import 'package:get/get.dart';
import 'package:university_finder_app/data/models/university_model.dart';
import 'package:university_finder_app/app/services/storage_service.dart';
import 'dart:convert';

class SavedController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  final savedUniversities = <UniversityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSaved();
  }

  void loadSaved() {
    final List<String> savedJson = _storage.prefs.getStringList('saved_unis') ?? [];
    savedUniversities.assignAll(
      savedJson.map((item) => UniversityModel.fromJson(jsonDecode(item))).toList(),
    );
  }

  Future<void> toggleSave(UniversityModel uni) async {
    final List<String> savedJson = _storage.prefs.getStringList('saved_unis') ?? [];
    final String uniId = uni.id ?? '';
    
    // Check if orready saved
    final index = savedJson.indexWhere((item) => UniversityModel.fromJson(jsonDecode(item)).id == uniId);

    if (index >= 0) {
      savedJson.removeAt(index);
    } else {
      savedJson.add(jsonEncode(uni.toJson()));
    }

    await _storage.prefs.setStringList('saved_unis', savedJson);
    loadSaved();
  }

  bool isSaved(String id) {
    return savedUniversities.any((u) => u.id == id);
  }
}
