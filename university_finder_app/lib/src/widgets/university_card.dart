import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../features/university/university_details_screen.dart';

// Widget to display university summary in a list
class UniversityCard extends StatelessWidget {
    final Map<String, dynamic> university;

    const UniversityCard({super.key, required this.university});

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UniversityDetailsScreen(university: university),
                    ),
                );
            },
            child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        // Image Placeholder
                        Container(
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                image: university['imageUrl'] != null ? DecorationImage(
                                    image: NetworkImage(university['imageUrl']), // Assuming mocked or real URL
                                    fit: BoxFit.cover,
                                ) : null,
                            ),
                            child: university['imageUrl'] == null ? const Center(child: Icon(Icons.school, size: 40, color: Colors.white)) : null,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        university['name'] ?? 'University Name',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                        children: [
                                            const Icon(Icons.location_on, size: 14, color: Colors.blueAccent),
                                            const SizedBox(width: 4),
                                            Text(
                                                university['location'] ?? 'Location',
                                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                                            ),
                                        ],
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
