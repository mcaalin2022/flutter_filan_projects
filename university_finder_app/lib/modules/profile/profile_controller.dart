import 'package:get/get.dart';
import 'package:university_finder_app/app/services/storage_service.dart';

class ProfileController extends GetxController {
  final _storage = Get.find<StorageService>();
  
  // Getters for user data from storage
  String get userName => _storage.prefs.getString('name') ?? 'User';
  String get userEmail => _storage.prefs.getString('user_email') ?? 'No Email';
  String get userRole => _storage.prefs.getString('user_role') ?? 'Student';

  // Logout is already handled in HomeController but can be here too
  void logout() {
    _storage.prefs.clear();
    Get.offAllNamed('/welcome');
  }
}
