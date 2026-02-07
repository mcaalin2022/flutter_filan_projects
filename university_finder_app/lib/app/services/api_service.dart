
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:university_finder_app/app/services/storage_service.dart';

class ApiService extends GetxService {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS/Web
  static const String baseUrl = 'http://10.0.2.2:5000/api';
  
  final _storage = Get.find<StorageService>();

  Future<ApiService> init() async {
    return this;
  }

  Map<String, String> _getHeaders() {
    final token = _storage.prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    try {
      print('GET Request: $baseUrl$endpoint');
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
      );
      print('GET Response [${response.statusCode}]: ${response.body}');
      return response;
    } catch (e) {
      print('GET Error: $e');
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint, dynamic data) async {
    try {
      print('POST Request: $baseUrl$endpoint');
      print('POST Body: ${jsonEncode(data)}');
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
        body: jsonEncode(data),
      );
      print('POST Response [${response.statusCode}]: ${response.body}');
      return response;
    } catch (e) {
      print('POST Error: $e');
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint, dynamic data) async {
    try {
      print('PUT Request: $baseUrl$endpoint');
      print('PUT Body: ${jsonEncode(data)}');
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
        body: jsonEncode(data),
      );
      print('PUT Response [${response.statusCode}]: ${response.body}');
      return response;
    } catch (e) {
      print('PUT Error: $e');
      rethrow;
    }
  }

  Future<http.Response> delete(String endpoint) async {
    try {
      print('DELETE Request: $baseUrl$endpoint');
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
      );
      print('DELETE Response [${response.statusCode}]: ${response.body}');
      return response;
    } catch (e) {
      print('DELETE Error: $e');
      rethrow;
    }
  }
}

