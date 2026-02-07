import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/utils/colors.dart';
import 'package:university_finder_app/modules/university/application_controller.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Apply to ${controller.university.name}', style: const TextStyle(fontSize: 18)),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please provide your academic and personal details.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 32),
            
            // Full Name Input
            _buildTextField(
              controller: controller.fullNameController,
              label: 'Full Name *',
              hint: 'Enter your full name',
              icon: Icons.person_outline,
            ),
            
            // Address Input
            _buildTextField(
              controller: controller.addressController,
              label: 'Current Address *',
              hint: 'City, District, State',
              icon: Icons.location_on_outlined,
            ),
            
            // Phone Number Input
            _buildTextField(
              controller: controller.phoneController,
              label: 'Phone Number *',
              hint: 'Enter digits only',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.number,
            ),
            
            // Graduate School Input
            _buildTextField(
              controller: controller.graduateSchoolController,
              label: 'Graduate School *',
              hint: 'High school name',
              icon: Icons.school_outlined,
            ),
            
            // Grade Input
            _buildTextField(
              controller: controller.gradeController,
              label: 'Grade / GPA *',
              hint: 'e.g., A, 3.5, 85%',
              icon: Icons.grade_outlined,
            ),
            
            // Age Input
            _buildTextField(
              controller: controller.ageController,
              label: 'Age *',
              hint: 'How old are you?',
              icon: Icons.calendar_today_outlined,
              keyboardType: TextInputType.number,
            ),

            // Gender Selection
            const Text('Gender', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Obx(() => Row(
              children: [
                _buildGenderOption('Male'),
                const SizedBox(width: 16),
                _buildGenderOption('Female'),
              ],
            )),
            
            const SizedBox(height: 24),
            
            // Faculties Interested
            const Text('Faculties Interested', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: controller.university.faculties?.map((faculty) => Obx(() {
                final isSelected = controller.selectedFaculties.contains(faculty);
                return FilterChip(
                  label: Text(faculty),
                  selected: isSelected,
                  onSelected: (_) => controller.toggleFaculty(faculty),
                  selectedColor: AppColors.primary.withOpacity(0.2),
                  checkmarkColor: AppColors.primary,
                  labelStyle: TextStyle(color: isSelected ? AppColors.primary : Colors.grey),
                  backgroundColor: AppColors.surface,
                );
              })).toList() ?? [],
            ),

            const SizedBox(height: 48),
            
            // Submit Button
            Obx(() => SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : () => controller.submitApplication(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: controller.isLoading.value 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit Application', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            )),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGenderOption(String value) {
    return GestureDetector(
      onTap: () => controller.gender.value = value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: controller.gender.value == value ? AppColors.primary.withOpacity(0.2) : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: controller.gender.value == value ? AppColors.primary : Colors.transparent),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: controller.gender.value == value ? AppColors.primary : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
