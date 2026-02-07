import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/modules/home/home_view.dart';
import 'package:university_finder_app/modules/search/search_view.dart';
import 'package:university_finder_app/modules/profile/profile_view.dart';
import 'package:university_finder_app/modules/university/saved_view.dart';
import 'package:university_finder_app/modules/home/main_controller.dart';
import 'package:university_finder_app/utils/colors.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeView(),
              SearchView(),
              SavedView(),
              ProfileView(),
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            backgroundColor: AppColors.surface,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Saved'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
          )),
    );
  }
}
