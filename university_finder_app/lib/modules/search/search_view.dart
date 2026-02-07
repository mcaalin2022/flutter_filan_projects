
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:university_finder_app/modules/search/search_controller.dart';
import 'package:university_finder_app/utils/colors.dart';
import 'package:university_finder_app/app/routes/app_routes.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.onSearch,
              decoration: InputDecoration(
                hintText: 'University name or location...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.searchQuery.isEmpty) {
                return const Center(child: Text('Start searching...', style: TextStyle(color: Colors.grey)));
              }

              if (controller.searchResults.isEmpty) {
                return const Center(child: Text('No results found', style: TextStyle(color: Colors.grey)));
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final uni = controller.searchResults[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(Routes.UNIVERSITY_DETAIL, arguments: uni),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              uni.imageUrl ?? 'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=600',
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              uni.name ?? 'University',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
