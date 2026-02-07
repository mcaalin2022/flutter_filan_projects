import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/app/services/storage_service.dart';
import 'package:university_finder_app/app/services/api_service.dart';
import 'package:university_finder_app/utils/theme.dart';
import 'package:university_finder_app/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => ApiService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'University Finder',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
    );
  }
}
