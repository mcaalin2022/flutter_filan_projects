// Importing material package for ChangeNotifier
import 'package:flutter/material.dart';

// Importing http package for making API requests
import 'package:http/http.dart' as http;

// Importing dart convert for JSON decoding
import 'dart:convert';

// Importing shared_preferences to persist tokens

// Class AuthProvider that extends ChangeNotifier to manage authentication state
class AuthProvider with ChangeNotifier {
    // Base URL for the backend API (10.0.2.2 is localhost for Android emulator)
    final String baseUrl = 'http://10.0.2.2:5000/api/users';
    
    // Variable to store the authentication token
    String? _token;
    
    // Variable to store the current user properties
    Map<String, dynamic>? _user;
    
    // Getter to check if the user is authenticated
    bool get isAuthenticated => _token != null;
    
    // Getter to access the user object
    Map<String, dynamic>? get user => _user;

    // Method to register a new user
    Future<bool> register(String name, String email, String password) async {
        // Implementing try-catch block for error handling
        try {
            // Making a POST request to the registration endpoint
            final response = await http.post(
                Uri.parse('$baseUrl/'),
                headers: {'Content-Type': 'application/json'},
                body: json.encode({
                    'name': name,
                    'email': email,
                    'password': password,
                }),
            );

            // Checking if the response status is 201 Created
            if (response.statusCode == 201) {
                // Return true if registration is successful
                return true;
            } else {
                // Printing error if registration failed
                print('Registration failed: ${response.body}');
                return false;
            }
        } catch (e) {
            // Printing exception details
            print('Error during registration: $e');
            return false;
        }
    }

    // Method to login a user
    Future<bool> login(String email, String password) async {
        // Implementing try-catch block
        try {
            // Making a POST request to the login endpoint
            final response = await http.post(
                Uri.parse('$baseUrl/login'),
                headers: {'Content-Type': 'application/json'},
                body: json.encode({
                    'email': email,
                    'password': password,
                }),
            );

            // Checking if the response status is 200 OK
            if (response.statusCode == 200) {
                // Decoding the response body
                final data = json.decode(response.body);
                
                // Saving the token and user data
                _token = data['token'];
                _user = data; // storing the whole user object
                
                // Persisting the token (optional implementation)
                // final prefs = await SharedPreferences.getInstance();
                // await prefs.setString('token', _token!);

                // Notifying listeners to update the UI
                notifyListeners();
                return true;
            } else {
                 print('Login failed: ${response.body}');
                return false;
            }
        } catch (e) {
             print('Error during login: $e');
            return false;
        }
    }

    // Method to logout the user
    void logout() {
        // Clearing the token
        _token = null;
        _user = null;
        // Notifying listeners
        notifyListeners();
    }
}
