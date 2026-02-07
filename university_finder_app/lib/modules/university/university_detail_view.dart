
import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:get/get.dart'; // Import GetX for navigation and state
import 'package:university_finder_app/utils/colors.dart'; // Import custom app colors
import 'package:university_finder_app/data/models/university_model.dart'; // Import university data model
import 'package:university_finder_app/modules/university/saved_controller.dart'; // Import saved controller

// UniversityDetailView displays comprehensive information about a specific university
class UniversityDetailView extends StatelessWidget {
  const UniversityDetailView({super.key}); // Standard constructor

  @override
  Widget build(BuildContext context) {
    // Retrieve the university object passed as an argument from the previous screen
    final UniversityModel university = Get.arguments;

    return DefaultTabController(
      length: 4, // Number of tabs: Admission, Programs, Fees, Requirements
      child: Scaffold(
        backgroundColor: AppColors.background, // Set background color from theme
        body: NestedScrollView( // Nested scroll view for SliverAppBar + TabBarView
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 250, // Height when fully expanded
                pinned: true, // Keep the app bar visible at the top when scrolled
                backgroundColor: AppColors.primary, // App bar primary color
                leading: IconButton( // Back button icon
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(), // Navigate back when pressed
                ),
                actions: [
                  GetX<SavedController>(
                    builder: (savedController) {
                      final isSaved = savedController.isSaved(university.id ?? '');
                      return IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? AppColors.primary : Colors.white,
                        ),
                        onPressed: () => savedController.toggleSave(university),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar( // Flexible space for image and overlay
                  background: Stack(
                    fit: StackFit.expand, // Fill entire flexible space
                    children: [
                      Image.network( // University banner image
                        university.imageUrl ?? 'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000',
                        fit: BoxFit.cover, // Cover the entire area
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Container( // Gradient overlay for readability
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black54, Colors.transparent, Colors.black87],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter( // Non-scrolling body content inside the header
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Outer padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Left align text
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread title and badge
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Left align
                              children: [
                                Text(
                                  university.name ?? 'University Name', // Display uni name
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold, // Bold text
                                    color: Colors.white, // White color for dark theme
                                  ),
                                ),
                                const SizedBox(height: 4), // Small vertical gap
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: AppColors.primary, size: 16), // Location icon
                                    Text(
                                      ' ${university.location}', // University location
                                      style: const TextStyle(color: Colors.grey), // Subtle grey text
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container( // Accreditation badge
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2), // Light primary tint
                              borderRadius: BorderRadius.circular(20), // Rounded badge
                            ),
                            child: const Text(
                              'MoE Accredited', // Accreditation status
                              style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24), // Vertical spacing before tabs
                      const TabBar( // Tab bar for detailing sections
                        isScrollable: true, // Allow horizontal scrolling of tabs
                        indicatorColor: AppColors.primary, // Active tab indicator color
                        labelColor: AppColors.primary, // Active tab text color
                        unselectedLabelColor: Colors.grey, // Inactive tab text color
                        dividerColor: Colors.transparent, // Remove default divider
                        tabs: [
                          Tab(text: 'Admission'), // Tab 1
                          Tab(text: 'Programs'), // Tab 2
                          Tab(text: 'Fees'), // Tab 3
                          Tab(text: 'Requirements'), // Tab 4
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView( // Content for each tab
            children: [
              // Build individual sections with corresponding university data
              _buildInfoSection(context, 'Admission Process', university.admissionInfo ?? 'Information about admission goes here.'),
              _buildProgramsSection(context, university),
              _buildInfoSection(context, 'Tuition & Fees', university.feesInfo ?? 'Details about tuition and registration fees.'),
              _buildInfoSection(context, 'Entry Requirements', university.requirementsInfo ?? 'Minimum requirements for enrollment.'),
            ],
          ),
        ),
        // Sticky bottom navigation for quick actions
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0), // Padding for buttons
          decoration: BoxDecoration(
            color: AppColors.surface, // Container background
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5)), // Top shadow
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton( // Secondary action button
                  onPressed: () {}, // Functionality placeholder
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16), // Button height
                    side: const BorderSide(color: AppColors.primary), // Primary border color
                  ),
                  child: const Text('Brochure'), // Button label
                ),
              ),
              const SizedBox(width: 16), // Spacing between buttons
              Expanded(
                child: ElevatedButton( // Primary action button
                  onPressed: () => Get.toNamed('/apply', arguments: university), // Navigate to application form
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, // Primary button color
                    padding: const EdgeInsets.symmetric(vertical: 16), // Button height
                  ),
                  child: const Text('Apply Now', style: TextStyle(color: Colors.white)), // White button label
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build a simple text-based info section
  Widget _buildInfoSection(BuildContext context, String title, String content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0), // Section padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Left align text
        children: [
          Text(
            title, // Subsection title
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16), // Spacing
          Text(
            content, // Subsection content
            style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.5), // Readable text
          ),
        ],
      ),
    );
  }

  // Helper widget to build the programs/faculties list with new design
  Widget _buildProgramsSection(BuildContext context, UniversityModel university) {
    final faculties = university.faculties ?? [];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgramCategory(context, 'Postgraduate', '2 programs available', 1, Colors.blue),
          const SizedBox(height: 16),
          _buildProgramCategory(context, 'Undergraduate', '${faculties.length} programs available', 2, Colors.green),
          const SizedBox(height: 16),
          // List of faculties as modern cards
          ...faculties.map((faculty) => _buildFacultyCard(faculty)),
        ],
      ),
    );
  }

  Widget _buildProgramCategory(BuildContext context, String title, String subtitle, int index, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$index',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildFacultyCard(String facultyName) {
    IconData getIcon(String name) {
      name = name.toLowerCase();
      if (name.contains('computer') || name.contains('it')) return Icons.computer;
      if (name.contains('engineering')) return Icons.settings;
      if (name.contains('medicine') || name.contains('health')) return Icons.medical_services;
      if (name.contains('business') || name.contains('economics')) return Icons.business;
      return Icons.school;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(getIcon(facultyName), color: Colors.green, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(facultyName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const Text('View departments and courses', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}


