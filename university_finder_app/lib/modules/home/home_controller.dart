import 'package:get/get.dart'; 
import 'package:university_finder_app/data/models/university_model.dart'; 
import 'package:university_finder_app/data/repositories/university_repository.dart'; 
import 'package:university_finder_app/app/services/storage_service.dart'; 
import 'package:university_finder_app/app/routes/app_routes.dart'; 

// HomeController wuxuu maamulaa xogta iyo maangalka bogga hore (Home Screen)
class HomeController extends GetxController {
  // Soo saarista Repository-ga jaamacadaha iyo Storage-ka xogta keydiya
  final UniversityRepository _repository = Get.find<UniversityRepository>();
  final StorageService _storage = Get.find<StorageService>();

  // State Management: List-gaan 'observable' ah wuxuu si toos ah u cusboonaysiiyaa UI-ga
  final universities = <UniversityModel>[].obs;
  // State: Variable-kan wuxuu xukumaa muujinta wareegga Loading-ka
  final isLoading = false.obs;

  // Logic: Function-kaan wuxuu xusuusta ka soo saaraa magaca user-ka ee keydsan
  String get userName => _storage.prefs.getString('name') ?? 'User';

  @override
  void onInit() {
    super.onInit(); 
    fetchAllUniversities(); // Isla marka bogga la rido, soo qaad xogta jaamacadaha
  }

  // Logic: Function-kaan wuxuu xogta jaamacadaha ka soo jiidaa Backend-ka
  Future<void> fetchAllUniversities() async {
    isLoading.value = true; // Bilaabista muqaalka Loading-ka
    try {
      // Wacitaanka Repository-ga si xogta looga keeno API-ga
      final List<UniversityModel> result = await _repository.getUniversities(); 
      universities.assignAll(result); // Xogta cusub ku shub List-ga UI-ga u muuqda
    } catch (e) {
      print('DEBUG: Khalad ayaa dhacay intii xogta la keenayay: $e'); 
    } finally {
      isLoading.value = false; // Labadii xaaladoodba (guul ama fashil) loading-ka jooji
    }
  }

  // Logic: Function-kaan wuxuu user-ka ka saaraa app-ka (Logout)
  Future<void> logout() async {
    await _storage.prefs.clear(); // Meel mari ka dhig (nadiifi) dhamaan xogta keydsan
    Get.offAllNamed(Routes.WELCOME); // User-ka dib ugu celi bogga hore ee Welcome-ka
  }
}




