import 'package:flutter/material.dart'; // Import Flutter material package
import 'package:get/get.dart'; // Import GetX for reactivity
import 'package:university_finder_app/utils/colors.dart'; // Import application colors
import 'package:university_finder_app/app/routes/app_routes.dart'; // Import app routes
import 'package:university_finder_app/modules/home/home_controller.dart'; // Import the controller
import 'package:university_finder_app/modules/home/main_controller.dart'; // Import MainController

// HomeView displays the main dashboard after login
class HomeView extends GetView<HomeController> {
  const HomeView({super.key}); // Constructor with key

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Ensures content is within screen boundaries
      child: SingleChildScrollView( // Enables scrolling for the entire page
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Standard outer padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              // Header section showing user profile and logout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute header elements
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Left aligned name info
                      children: [
                        Text(
                          'Welcome back,', // Static greeting
                          style: Theme.of(context).textTheme.bodySmall, // Small text style
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Profile tab in MainView
                            Get.find<MainController>().currentIndex.value = 3;
                          },
                          child: Text( // Display user name
                            controller.userName, // Name from storage
                            overflow: TextOverflow.ellipsis, // Handle long names
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold, // Bold emphasis
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton( // Logout button
                    onPressed: () => controller.logout(), // Trigger logout logic
                    icon: const Icon(Icons.logout, color: Colors.redAccent), // Red logout icon
                    tooltip: 'Logout', // Tooltip for accessibility
                  ),
                ],
              ),
              const SizedBox(height: 24), // Vertical spacing
              
              // Search bar for university discovery (Navigates to Search Tab)
              TextField(
                readOnly: true,
                onTap: () => Get.find<MainController>().currentIndex.value = 1,
                decoration: InputDecoration(
                  hintText: 'Search universities...', // Placeholder text
                  prefixIcon: const Icon(Icons.search), // Leading search icon
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    borderSide: BorderSide.none, // No outer border line
                  ),
                  filled: true, // Enable background color
                  fillColor: AppColors.surface, // Background fill
                ),
              ),
              const SizedBox(height: 24), // Vertical spacing
              
              // Title for the all universities list
              const Text(
                'All Universities', // Headline for the list
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Styled headline
              ),
              const SizedBox(height: 16), // Vertical spacing
              
              // Grid layout for university listing
              Obx(() {
                if (controller.isLoading.value) { // Checking loading state
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()), // Show spinner
                  );
                }
                
                if (controller.universities.isEmpty) { // Checking for empty data
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text('No universities found')), // Show empty message
                  );
                }

                // GridView for 2-column layout as requested
                return GridView.builder(
                  shrinkWrap: true, // Adjust to content height
                  physics: const NeverScrollableScrollPhysics(), // Scroll handled by Parent
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    crossAxisSpacing: 16, // Horizontal gap
                    mainAxisSpacing: 16, // Vertical gap
                    childAspectRatio: 0.85, // Adjust card height/width ratio
                  ),
                  itemCount: controller.universities.length, // Number of items
                  itemBuilder: (context, index) {
                    final uni = controller.universities[index]; // Current university item
                    return GestureDetector(
                      onTap: () => Get.toNamed(Routes.UNIVERSITY_DETAIL, arguments: uni), // Navigate on click
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface, // Background color
                          borderRadius: BorderRadius.circular(20), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // University Image with "Active" Badge
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  child: Image.network(
                                    uni.imageUrl ?? 'https://images.unsplash.com/photo-1541339907198-e021fc2d2e7c?q=80&w=600',
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=600',
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Active',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // University Name and Location
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    uni.name ?? 'University',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    uni.location ?? 'Somalia',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
