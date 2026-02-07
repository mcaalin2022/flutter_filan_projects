import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/app/services/api_service.dart';
import 'package:university_finder_app/data/models/university_model.dart';

class ApplicationController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  // University being applied to
  late UniversityModel university;

  // Form controllers
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final graduateSchoolController = TextEditingController();
  final gradeController = TextEditingController();
  final ageController = TextEditingController();
  
  // State variables
  final RxString gender = 'Male'.obs;
  final RxList<String> selectedFaculties = <String>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the university data passed as an argument
    university = Get.arguments;
  }

  // Toggle faculty selection
  void toggleFaculty(String faculty) {
    if (selectedFaculties.contains(faculty)) {
      selectedFaculties.remove(faculty);
    } else {
      selectedFaculties.add(faculty);
    }
  }

  // Submit the application form to the backend
  Future<void> submitApplication() async {
    // Basic validation
    if (fullNameController.text.isEmpty || addressController.text.isEmpty || 
        phoneController.text.isEmpty || graduateSchoolController.text.isEmpty ||
        gradeController.text.isEmpty || ageController.text.isEmpty ||
        selectedFaculties.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields and select at least one faculty', 
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        'universityId': university.id,
        'fullName': fullNameController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'graduateSchool': graduateSchoolController.text,
        'grade': gradeController.text,
        'age': int.tryParse(ageController.text) ?? 18,
        'gender': gender.value,
        'facultiesInterested': selectedFaculties,
      };

      final response = await _apiService.post('/applications', body);
      
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Application submitted successfully to ${university.name}!',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/home'); // Return to home or applications list
      } else {
        print('Application Submission Failed: ${response.statusCode}');
        print('Response Body: ${response.body}');
        Get.snackbar('Error', 'Failed to submit application. Please try again.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    graduateSchoolController.dispose();
    gradeController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
