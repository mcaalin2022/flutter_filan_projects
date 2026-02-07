// Importing material package
import 'package:flutter/material.dart';

// Importing http package
import 'package:http/http.dart' as http;

// Importing dart convert
import 'dart:convert';

// Class UniversityProvider to manage university data
class UniversityProvider with ChangeNotifier {
  // Base URL for the backend API
  final String baseUrl = 'http://10.0.2.2:5000/api/universities';

  // List to store universities
  List<dynamic> _universities = [];

  // Getter to access the list
  List<dynamic> get universities => _universities;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Method to fetch universities (optionally with a keyword)
  Future<void> fetchUniversities({String? keyword}) async {
    // Setting loading to true
    _isLoading = true;
    // Notifying listeners
    notifyListeners();

    try {
      // Constructing the URL with query parameter if keyword exists
      String url = baseUrl;
      if (keyword != null && keyword.isNotEmpty) {
        url += '?keyword=$keyword';
      }

      // Making the GET request
      final response = await http.get(Uri.parse(url));

      // Checking status code
      if (response.statusCode == 200) {
        // Decoding the list
        _universities = json.decode(response.body);
      } else {
        print('Failed to load universities: ${response.body}');
      }
    } catch (e) {
      print('Error fetching universities: $e');
    } finally {
      // Setting loading to false
      _isLoading = false;
      // Notifying listeners
      notifyListeners();
    }
  }
}
