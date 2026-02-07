import 'package:get/get.dart';
import 'package:university_finder_app/data/models/university_model.dart';
import 'package:university_finder_app/data/repositories/university_repository.dart';

// SearchController wuxuu maamulaa raadinta iyo shaandhaynta jaamacadaha
class SearchController extends GetxController {
  final UniversityRepository _repository = Get.find<UniversityRepository>();

  // State Management: List-kaan wuxuu hayaa natiijada raadinta u muuqata UI-ga
  final searchResults = <UniversityModel>[].obs;
  // State: Inuu app-ku mashquul ku yahay raadinta iyo in kale
  final isLoading = false.obs;
  // State: Qoraalka hadda user-ku uu baarayo
  final searchQuery = ''.obs;

  // Logic: Function-kaan wuxuu shaandheeyaa jaamacadaha iyadoo la raacayo magaca ama goobta
  void onSearch(String query) async {
    searchQuery.value = query; // Bedelaadda state-ka raadinta
    
    // Haddii meesha raadintu banaan tahay, nadiifi natiijada
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true; // Bilaabista loading-ka
    try {
      // Soo qaad dhamaan jaamacadaha si app-ka dhexdiisa loogu shaandheeyo (Client-side filtering logic)
      final all = await _repository.getUniversities();
      searchResults.assignAll(
        all.where((u) => 
          u.name!.toLowerCase().contains(query.toLowerCase()) ||
          u.location!.toLowerCase().contains(query.toLowerCase())
        ).toList(),
      );
    } finally {
      isLoading.value = false; // Labadii xaaladoodba loading-ka jooji
    }
  }
}


