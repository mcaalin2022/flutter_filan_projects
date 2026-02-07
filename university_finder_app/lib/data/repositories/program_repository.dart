import 'dart:convert';
import 'package:get/get.dart';
import 'package:university_finder_app/app/services/api_service.dart';
import 'package:university_finder_app/data/models/program_model.dart';

class ProgramRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<List<ProgramModel>> getAllPrograms() async {
    try {
      final response = await _apiService.get('/programs');
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

  Future<List<ProgramModel>> getProgramsByUniversity(String universityId) async {
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

