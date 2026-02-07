
import 'dart:convert';
import 'package:get/get.dart';
import 'package:university_finder_app/app/services/api_service.dart';
import 'package:university_finder_app/data/models/university_model.dart';
import 'package:university_finder_app/data/models/program_model.dart';

class UniversityRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<List<UniversityModel>> getUniversities() async {
    try {
      final response = await _apiService.get('/universities');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((u) => UniversityModel.fromJson(u))
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<UniversityModel?> getUniversityById(String id) async {
    try {
      final response = await _apiService.get('/universities/$id');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return UniversityModel.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<ProgramModel>> getUniversityPrograms(String universityId) async {
    try {
      final response = await _apiService.get('/programs/university/$universityId');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((p) => ProgramModel.fromJson(p))
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

