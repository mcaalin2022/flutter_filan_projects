// Importing material package
import 'package:flutter/material.dart';

// Importing App Colors
import '../../constants/colors.dart';

// Importing Login Screen (will be created next)
import '../auth/login_screen.dart';

// StatefulWidget for the Welcome Screen
class WelcomeScreen extends StatelessWidget {
    const WelcomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
        // Scaffold widget for the basic page structure
        return Scaffold(
            // Background color for the screen
            backgroundColor: AppColors.background,
            // Body container
            body: SafeArea(
                child: Padding(
                    // Adding padding around the content
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                        // Aligning children to the center
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            // Placeholder for Image (as seen in design 'Welcome to University Finder')
                            // Ideally use Image.asset('assets/welcome_image.png')
                            Container(
                                height: 300,
                                decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(20),
                                    // Image placement here
                                ),
                                child: const Center(
                                    child: Icon(Icons.school, size: 100, color: Colors.white),
                                ),
                            ),
                            
                            // Spacer for vertical spacing
                            const SizedBox(height: 48.0),
                            
                            // Title Text
                            const Text(
                                'Welcome to\nUniversity Finder',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                ),
                            ),
                            
                            // Spacer
                            const SizedBox(height: 16.0),
                            
                            // Subtitle Text
                            const Text(
                                'Empowering Somali students to discover, compare, and connect with the best universities for their career goals.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white70,
                                ),
                            ),
                            
                            // Spacer
                            const SizedBox(height: 48.0),
                            
                            // Get Started Button
                            ElevatedButton(
                                onPressed: () {
                                    // Navigating to the Login Screen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                                    );
                                },
                                style: ElevatedButton.styleFrom(
                                    // Button background color
                                    backgroundColor: AppColors.highlight,
                                    // Button padding
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    // Button shape
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                    ),
                                ),
                                child: const Text(
                                    'Get Started ->',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
