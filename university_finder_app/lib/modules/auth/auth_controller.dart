import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/app/routes/app_routes.dart';
import 'package:university_finder_app/data/repositories/auth_repository.dart';
import 'package:university_finder_app/app/services/storage_service.dart';

// AuthController wuxuu maamulaa dhamaan shaqooyinka aqoonsiga (Authentication)
class AuthController extends GetxController {
  // Waxaan halkan ku soo xireynaa Repository-ga xogta keena iyo Storage-ka xogta keydiya
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final StorageService _storage = Get.find<StorageService>();

  // Kuwani waa Controllers-ka maamula qoraalada ay user-adu soo galiyaan (Input fields)
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final resetEmailController = TextEditingController();
  final resetPasswordController = TextEditingController();
  final resetConfirmPasswordController = TextEditingController();

  // State Management: Variables-kaan waxay si toos ah u bedelaan UI-ga (Observable)
  final isPasswordVisible = false.obs; // In password-ka la arko iyo in kale
  final isLoading = false.obs;         // Inuu app-ku mashquul (Loading) yahay
  final selectedRole = 'user'.obs;    // Doorka qofka (User ama Admin)

  // Logic: Function-kaan wuxuu bedelaa muqaalka password-ka (Indhaha)
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Logic: Function-kaan wuxuu maamulaa soo gelitaanka (Login)
  Future<void> login() async {
    // Hubinta in dhamaan meelaha banaan la buuxiyey
    if (loginEmailController.text.isEmpty ||
        loginPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Fadlan buuxi dhamaan meelaha banaan');
      return;
    }

    isLoading.value = true; // Bilaabista muqaalka Loading-ka
    final user = await _authRepository.login(
      loginEmailController.text.trim(),
      loginPasswordController.text,
    );
    isLoading.value = false; // Joojinta Loading-ka markay xogtu timaado

    // Haddii login-ku guulaysto, xogta user-ka ayaa la keydinayaa (State persistence)
    if (user != null && user.token != null) {
      await _storage.prefs.setString('token', user.token!);
      await _storage.prefs.setString('name', user.name ?? 'User');
      await _storage.prefs.setString('user_email', user.email!);
      await _storage.prefs.setString('user_role', user.role ?? 'user');
      
      // Kala saarista halka qofku aadayo (Routing Logic)
      if (user.role == 'admin') {
        Get.offAllNamed(Routes.ADMIN_DASHBOARD);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      Get.snackbar('Error', 'Email-ka ama Password-ka waa khalad');
    }
  }

  // Logic: Function-kaan wuxuu maamulaa diwaangelinta cusub (Register)
  Future<void> register() async {
    if (registerNameController.text.isEmpty ||
        registerEmailController.text.isEmpty ||
        registerPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Fadlan buuxi dhamaan meelaha banaan');
      return;
    }

    if (registerPasswordController.text !=
        registerConfirmPasswordController.text) {
      Get.snackbar('Error', 'Password-yadu isma waafaqsana');
      return;
    }

    isLoading.value = true;
    try {
      final user = await _authRepository.register(
        registerNameController.text.trim(),
        registerEmailController.text.trim(),
        registerPasswordController.text,
        role: selectedRole.value,
      );
      isLoading.value = false;

      if (user != null && user.token != null) {
        await _storage.prefs.setString('token', user.token!);
        await _storage.prefs.setString('name', user.name ?? 'User');
        await _storage.prefs.setString('user_email', user.email!);
        await _storage.prefs.setString('user_role', user.role ?? 'user');

        if (user.role == 'admin') {
          Get.offAllNamed(Routes.ADMIN_DASHBOARD);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.snackbar('Error', 'Diwaangelintu way fashilantay. Hubi xogtaada.');
      }
    } catch (e) {
      isLoading.value = false;
      String message = 'Khalad ayaa dhacay intii lagu jiray diwaangelinta';
      if (e.toString().contains('SocketException')) {
        message = 'Server-ka lama xiriiri karo. Hubi internet-ka.';
      } else if (e.toString().contains('User already exists')) {
        message = 'User-kan horay ayuu u jiray.';
      }
      Get.snackbar('Error', message);
      print('AuthController Register Error: $e');
    }
  }

  // Logic: Function-kaan wuxuu bedelaa password-ka haddii la ilaawo
  Future<void> resetPassword() async {
    if (resetEmailController.text.isEmpty ||
        resetPasswordController.text.isEmpty ||
        resetConfirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Fadlan buuxi dhamaan meelaha banaan');
      return;
    }

    if (resetPasswordController.text != resetConfirmPasswordController.text) {
      Get.snackbar('Error', 'Password-yadu isma waafaqsana');
      return;
    }

    isLoading.value = true;
    final success = await _authRepository.resetPassword(
      resetEmailController.text.trim(),
      resetPasswordController.text,
    );
    isLoading.value = false;

    if (success) {
      Get.snackbar('Guul', 'Password-ka si sax ah ayaa loo bedelay');
      Get.offNamed(Routes.LOGIN);
      // Nadiifinta meelaha wax laga qoro (State reset)
      resetEmailController.clear();
      resetPasswordController.clear();
      resetConfirmPasswordController.clear();
    } else {
      Get.snackbar('Error', 'Password-ka lama bedeli karo. User-ka lama helin.');
    }
  }
}


