import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class UniversityDetailsScreen extends StatelessWidget {
    final Map<String, dynamic> university;

    const UniversityDetailsScreen({super.key, required this.university});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.background,
            body: CustomScrollView(
                slivers: [
                    SliverAppBar(
                        expandedHeight: 250.0,
                        backgroundColor: AppColors.background,
                        flexibleSpace: FlexibleSpaceBar(
                            background: university['imageUrl'] != null ? Image.network(university['imageUrl'], fit: BoxFit.cover) : Container(color: Colors.grey),
                        ),
                        leading: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                            child: const BackButton(color: Colors.white),
                        ),
                        actions: [
                            Container(
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                                child: IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
                            ),
                        ],
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        university['name'] ?? 'Name',
                                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                        children: [
                                            const Icon(Icons.location_on, color: AppColors.highlight, size: 16),
                                            const SizedBox(width: 4),
                                            Text(university['location'] ?? 'Location', style: const TextStyle(color: Colors.white70)),
                                        ],
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // Stats Row
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            _buildStat('Type', university['type'] ?? 'Public'),
                                            _buildStat('Duration', university['duration'] ?? '4 years'),
                                            _buildStat('Tuition', university['tuition'] ?? '\$500'),
                                        ],
                                    ),
                                    const SizedBox(height: 24),

                                    const Text('About University', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    const SizedBox(height: 8),
                                    Text(
                                        university['description'] ?? 'No description available.',
                                        style: const TextStyle(color: Colors.white70, height: 1.5),
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    const Text('Programs Offered', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    const SizedBox(height: 12),
                                    // Mock programs if none exist
                                    if (university['programs'] != null)
                                        ...(university['programs'] as List).map((p) => ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: const Icon(Icons.school, color: AppColors.highlight),
                                            title: Text(p['name'], style: const TextStyle(color: Colors.white)),
                                            subtitle: Text(p['details'] ?? '', style: const TextStyle(color: Colors.white38)),
                                        ))
                                    else
                                        const Text('Faculty of Medicine\nFaculty of Engineering', style: TextStyle(color: Colors.white70)),

                                    const SizedBox(height: 32),
                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.highlight,
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            ),
                                            child: const Text('Apply Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ),
                                    ),
                                    const SizedBox(height: 20),
                                ],
                            ),
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildStat(String label, String value) {
        return Column(
            children: [
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                const SizedBox(height: 4),
                Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
            ],
        );
    }
}
