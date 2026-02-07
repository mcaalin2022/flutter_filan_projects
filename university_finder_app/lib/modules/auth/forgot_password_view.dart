import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/modules/auth/auth_controller.dart';
import 'package:university_finder_app/utils/colors.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.lock_reset_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Forgot Your Password?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your email and a new password to reset your account.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              
              _buildTextField(
                controller: controller.resetEmailController,
                label: 'Email Address',
                hint: 'Enter your registered email',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              
              Obx(() => _buildTextField(
                controller: controller.resetPasswordController,
                label: 'New Password',
                hint: 'Enter your new password',
                icon: Icons.lock_outline,
                isPassword: true,
                obscureText: !controller.isPasswordVisible.value,
                onSuffixIconTap: controller.togglePasswordVisibility,
              )),
              const SizedBox(height: 20),
              
              Obx(() => _buildTextField(
                controller: controller.resetConfirmPasswordController,
                label: 'Confirm New Password',
                hint: 'Re-enter your new password',
                icon: Icons.lock_outline,
                isPassword: true,
                obscureText: !controller.isPasswordVisible.value,
                onSuffixIconTap: controller.togglePasswordVisibility,
              )),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.resetPassword(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Update Password',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(icon, color: AppColors.primary),
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: onSuffixIconTap,
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
