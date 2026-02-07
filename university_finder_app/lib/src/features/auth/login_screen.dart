// Importing material package
import 'package:flutter/material.dart';

// Importing provider package
import 'package:provider/provider.dart';

// Importing App Colors
import '../../constants/colors.dart';

// Importing Auth Provider
import '../../providers/auth_provider.dart';

// Importing Home Screen
import '../home/home_screen.dart';

// Importing Register Screen
import 'register_screen.dart';

// StatefulWidget for Login Screen to handle text controllers
class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    // Controller for email input
    final _emailController = TextEditingController();
    // Controller for password input
    final _passwordController = TextEditingController();
    
    // Loading state for the button
    bool _isLoading = false;

    // Method to handle login
    // Commenting on line logic:
    void _handleLogin() async {
        // Validation check
        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields')),
            );
            return;
        }

        // Setting loading to true to show spinner
        setState(() => _isLoading = true);

        // Calling the provider's login method
        final success = await Provider.of<AuthProvider>(context, listen: false)
            .login(_emailController.text, _passwordController.text);

        // Setting loading back to false
        setState(() => _isLoading = false);

        // If login is successful
        if (success) {
            // Navigate to Home Screen and remove all previous routes
            if (mounted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                );
            }
        } else {
            // Show error message
            if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed. Check credentials.')),
                );
            }
        }
    }

    @override
    Widget build(BuildContext context) {
        // Scaffold for structure
        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: Colors.white),
            ),
            // Body container
            body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // Title
                            const Text(
                                'Welcome to UniFinder',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                                'Find your future in Somalia',
                                style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 48),

                            // Tab switch (Login / Register) mock using Row
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColors.cardBackground,
                                    borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                    children: [
                                        Expanded(
                                            child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                decoration: BoxDecoration(
                                                    color: AppColors.highlight,
                                                    borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: const Center(
                                                    child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
                                                ),
                                            ),
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                                onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                                    );
                                                },
                                                child: const Center(
                                                    child: Text('Register', style: TextStyle(color: Colors.white70)),
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            const SizedBox(height: 32),

                            // Email Field
                            const Text('Email or Phone Number', style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 8),
                            TextField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter your email or phone',
                                    hintStyle: const TextStyle(color: Colors.white38),
                                    filled: true,
                                    fillColor: AppColors.cardBackground,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
                                ),
                            ),
                            const SizedBox(height: 24),

                            // Password Field
                            const Text('Password', style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 8),
                            TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    hintStyle: const TextStyle(color: Colors.white38),
                                    filled: true,
                                    fillColor: AppColors.cardBackground,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                                    suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.white70),
                                ),
                            ),
                            
                            // Log In Button
                            const SizedBox(height: 32),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: _isLoading ? null : _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.highlight,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: _isLoading 
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text('Log In', style: TextStyle(fontSize: 16, color: Colors.white)),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
