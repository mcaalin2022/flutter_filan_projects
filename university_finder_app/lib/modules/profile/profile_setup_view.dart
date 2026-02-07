
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/utils/colors.dart';
import '../../app/routes/app_routes.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  String selectedStream = 'Science';
  final List<String> subjects = ['Maths', 'Physics', 'Biology', 'Chemistry', 'English', 'Somali'];
  final List<String> selectedSubjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Setup')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Academic Background',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select your high school stream to customize your experience.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildStreamOption('Science'),
                  const SizedBox(width: 12),
                  _buildStreamOption('Arts'),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Subjects Taken', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: subjects.map((subject) => _buildSubjectChip(subject)).toList(),
              ),
               const SizedBox(height: 24),
               const Text('National Exam Score (%)', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold)),
               const SizedBox(height: 8),
               TextField(
                 keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'e.g. 85.5',
                    prefixIcon: Icon(Icons.percent),
                  ),
               ),
               const Spacer(),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: () => Get.offAllNamed(Routes.HOME),
                   child: const Text('Find Universities ->'),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreamOption(String label) {
    final isSelected = selectedStream == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedStream = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.withOpacity(0.3)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectChip(String label) {
     final isSelected = selectedSubjects.contains(label);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            selectedSubjects.add(label);
          } else {
            selectedSubjects.remove(label);
          }
        });
      },
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
    );
  }
}
