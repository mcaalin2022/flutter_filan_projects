

import 'dart:convert';
import 'package:get/get.dart';
import 'package:university_finder_app/app/services/api_service.dart';
import 'package:university_finder_app/data/models/user_model.dart';

class AuthRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return UserModel.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      print('AuthRepository Login Error: $e');
      rethrow;
    }
  }

  Future<UserModel?> register(String name, String email, String password, {String? role}) async {
    try {
      final response = await _apiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
        'role': role ?? 'user',
      });

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return UserModel.fromJson(data['data']);
        }
      } else {
        final data = jsonDecode(response.body);
        print('Registration failed with status ${response.statusCode}: ${data['message']}');
      }
      return null;
    } catch (e) {
      print('AuthRepository Register Error: $e');
      rethrow;
    }
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final response = await _apiService.post('/auth/reset-password', {
        'email': email,
        'password': newPassword,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('AuthRepository ResetPassword Error: $e');
      return false;
    }
  }

}

