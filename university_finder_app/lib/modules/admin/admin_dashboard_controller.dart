import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/app/services/api_service.dart';
import 'package:university_finder_app/app/services/storage_service.dart';

class AdminDashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiService _apiService = Get.find<ApiService>();

  late TabController tabController;

  // Observable states
  final RxMap stats = {}.obs;
  final RxList users = [].obs;
  final RxList applications = [].obs;
  final RxList universities = [].obs;
  final RxList programs = [].obs;
  final RxBool isLoading = false.obs;
  final RxBool isCreatingUser = false.obs;
  final RxBool isCreatingUniversity = false.obs;
  final RxBool isCreatingProgram = false.obs;
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    fetchAllData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    tabController.animateTo(index);
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    try {
      await Future.wait([
        fetchStats(),
        fetchUsers(),
        fetchUniversities(),
        fetchPrograms(),
        fetchApplications(),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStats() async {
    try {
      final response = await _apiService.get('/applications/stats');
      if (response.statusCode == 200) {
        stats.value = (jsonDecode(response.body))['data'];
      }
    } catch (e) {
      print('Stats Error: $e');
    }
  }

  Future<void> fetchUsers() async {
    try {
      final response = await _apiService.get('/admin/users');
      if (response.statusCode == 200) {
        users.value = (jsonDecode(response.body))['data'];
      }
    } catch (e) {
      print('Users Error: $e');
    }
  }

  Future<void> fetchApplications() async {
    try {
      final response = await _apiService.get('/applications/all');
      if (response.statusCode == 200) {
        applications.value = (jsonDecode(response.body))['data'];
      }
    } catch (e) {
      print('Applications Error: $e');
    }
  }

  Future<void> fetchUniversities() async {
    try {
      final response = await _apiService.get('/universities');
      if (response.statusCode == 200) {
        universities.value = (jsonDecode(response.body))['data'];
      }
    } catch (e) {
      print('Universities Error: $e');
    }
  }

  Future<void> fetchPrograms() async {
    try {
      final response = await _apiService.get('/programs');
      if (response.statusCode == 200) {
        programs.value = (jsonDecode(response.body))['data'];
      }
    } catch (e) {
      print('Programs Error: $e');
    }
  }

  void logout() async {
    final storage = Get.find<StorageService>();
    await storage.prefs.clear();
    Get.offAllNamed('/login');
  }

  Future<bool> createUser(
    String name,
    String email,
    String password,
    String role,
  ) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return false;
    }

    isCreatingUser.value = true;
    try {
      final response = await _apiService.post('/admin/users', {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      });

      if (response.statusCode == 201) {
        await Future.wait([fetchUsers(), fetchStats()]);
        Get.back(); // Close the dialog first
        Get.snackbar(
          'Success',
          'User created and saved to database successfully',
        );
        return true;
      } else {
        final error =
            jsonDecode(response.body)['message'] ?? 'Failed to create user';
        Get.snackbar('Error', error);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: Failed to save data');
      return false;
    } finally {
      isCreatingUser.value = false;
    }
  }

  // Update User Role (Admin/User)
  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      final response = await _apiService.put('/admin/users/$userId', {
        'role': newRole,
      });
      if (response.statusCode == 200) {
        fetchUsers();
        fetchStats();
        Get.snackbar('Success', 'User role updated to $newRole');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update role');
    }
  }

  // Delete User
  Future<void> deleteUser(String userId) async {
    try {
      final response = await _apiService.delete('/admin/users/$userId');
      if (response.statusCode == 200) {
        users.removeWhere((u) => u['_id'] == userId);
        fetchStats();
        Get.snackbar('Success', 'User deleted');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete user');
    }
  }

  // Delete Application
  Future<void> deleteApplication(String appId) async {
    try {
      final response = await _apiService.delete('/applications/$appId');
      if (response.statusCode == 200) {
        applications.removeWhere((a) => a['_id'] == appId);
        fetchStats(); // Update total registrations count
        Get.snackbar('Success', 'Application deleted');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete application');
    }
  }

  // --- University CRUD ---
  Future<bool> createUniversity(Map<String, dynamic> data) async {
    isCreatingUniversity.value = true;
    try {
      final response = await _apiService.post('/universities', data);
      if (response.statusCode == 201) {
        await Future.wait([fetchUniversities(), fetchStats()]);
        Get.back(); // Close the dialog first
        Get.snackbar('Success', 'University created successfully');
        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Failed to create university';
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create university');
    } finally {
      isCreatingUniversity.value = false;
    }
    return false;
  }

  Future<bool> updateUniversity(String id, Map<String, dynamic> data) async {
    isCreatingUniversity.value = true;
    try {
      final response = await _apiService.put('/universities/$id', data);
      if (response.statusCode == 200) {
        await fetchUniversities();
        Get.back(); // Close the dialog first
        Get.snackbar('Success', 'University updated successfully');
        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Failed to update university';
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update university');
    } finally {
      isCreatingUniversity.value = false;
    }
    return false;
  }

  Future<void> deleteUniversity(String id) async {
    try {
      final response = await _apiService.delete('/universities/$id');
      if (response.statusCode == 200) {
        universities.removeWhere((u) => u['_id'] == id);
        fetchStats();
        Get.snackbar('Success', 'University deleted');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete university');
    }
  }

  // --- Program CRUD ---
  Future<bool> createProgram(Map<String, dynamic> data) async {
    isCreatingProgram.value = true;
    try {
      final response = await _apiService.post('/programs', data);
      if (response.statusCode == 201) {
        await fetchPrograms();
        Get.back(); // Close the dialog first
        Get.snackbar('Success', 'Program created successfully');
        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Failed to create program';
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create program');
    } finally {
      isCreatingProgram.value = false;
    }
    return false;
  }

  Future<bool> updateProgram(String id, Map<String, dynamic> data) async {
    isCreatingProgram.value = true;
    try {
      final response = await _apiService.put('/programs/$id', data);
      if (response.statusCode == 200) {
        await fetchPrograms();
        Get.back(); // Close the dialog first
        Get.snackbar('Success', 'Program updated successfully');
        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Failed to update program';
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update program');
    } finally {
      isCreatingProgram.value = false;
    }
    return false;
  }

  Future<void> deleteProgram(String id) async {
    try {
      final response = await _apiService.delete('/programs/$id');
      if (response.statusCode == 200) {
        programs.removeWhere((p) => p['_id'] == id);
        Get.snackbar('Success', 'Program deleted');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete program');
    }
  }
}
