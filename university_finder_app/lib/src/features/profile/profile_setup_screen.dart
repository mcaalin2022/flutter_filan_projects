import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../home/home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
    const ProfileSetupScreen({super.key});

    @override
    State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
    // List to store selected subjects
    final List<String> _subjects = ['Mathematics', 'Biology', 'Physics', 'Chemistry', 'English', 'Somali'];
    final Map<String, String> _grades = {};

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
                title: const Text('Profile Setup', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent,
                leading: const BackButton(color: Colors.white),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Text(
                            'Academic Background',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                            'Select your high school streams to customize your suggestions.',
                            style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 24),
                        
                        // Subject Selection Grid (Mockup)
                        Expanded(
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                ),
                                itemCount: _subjects.length,
                                itemBuilder: (context, index) {
                                    final subject = _subjects[index];
                                    final isSelected = _grades.containsKey(subject);
                                    return GestureDetector(
                                        onTap: () {
                                            setState(() {
                                                if (isSelected) {
                                                    _grades.remove(subject);
                                                } else {
                                                    _grades[subject] = 'A'; // Default grade
                                                }
                                            });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: isSelected ? AppColors.highlight : AppColors.cardBackground,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: isSelected ? AppColors.highlight : Colors.white24),
                                            ),
                                            child: Center(
                                                child: Text(
                                                    subject,
                                                    style: TextStyle(
                                                        color: isSelected ? Colors.white : Colors.white70,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            ),
                                        ),
                                    );
                                },
                            ),
                        ),
                        
                        // National Exam Score Input
                        const Text('National Exam Score (%)', style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 8),
                        TextField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.cardBackground,
                                hintText: 'e.g., 85.5',
                                hintStyle: const TextStyle(color: Colors.white38),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            ),
                        ),
                         const SizedBox(height: 24),

                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                    // Save logic and navigate
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                    );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.highlight,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Find Universities ->', style: TextStyle(fontSize: 16, color: Colors.white)),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
