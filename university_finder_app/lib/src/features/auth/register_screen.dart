// Importing material package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../providers/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
    const RegisterScreen({super.key});

    @override
    State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    bool _isLoading = false;

    void _handleRegister() async {
        if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields')));
             return;
        }

        setState(() => _isLoading = true);
        final success = await Provider.of<AuthProvider>(context, listen: false)
            .register(_nameController.text, _emailController.text, _passwordController.text);
        setState(() => _isLoading = false);

        if (success && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful! Please login.')));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else if (mounted) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration failed.')));
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.background,
             appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: BackButton(color: Colors.white, onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()))),
            ),
            body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                             const SizedBox(height: 32),
                            
                            // Name Field
                            const Text('Full Name', style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 8),
                            TextField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: true, fillColor: AppColors.cardBackground,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                    prefixIcon: const Icon(Icons.person, color: Colors.white70),
                                ),
                            ),
                            const SizedBox(height: 16),

                            // Email Field
                             const Text('Email', style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 8),
                             TextField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: true, fillColor: AppColors.cardBackground,
                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                    prefixIcon: const Icon(Icons.email, color: Colors.white70),
                                ),
                            ),
                            const SizedBox(height: 16),

                            // Password
                             const Text('Password', style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 8),
                             TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: true, fillColor: AppColors.cardBackground,
                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                    prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                                ),
                            ),

                            const SizedBox(height: 32),
                             SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: _isLoading ? null : _handleRegister,
                                     style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.highlight,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Register', style: TextStyle(fontSize: 16, color: Colors.white)),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
