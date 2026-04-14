import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isLoginPasswordVisible = false.obs;
  final isRegisterPasswordVisible = false.obs;
  final isRegisterConfirmPasswordVisible = false.obs;

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) return 'Phone number must be exactly 10 digits';
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 6) return 'At least 6 characters required';
    return null;
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;
    final success = await _authService.login(
      phone: loginPhoneController.text.trim(),
      password: loginPasswordController.text.trim(),
    );
    isLoading.value = false;
    if (!success) {
      Get.snackbar('Login Failed', 'Invalid credentials or no registered user.');
      return;
    }
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;
    if (registerPasswordController.text.trim() !=
        registerConfirmPasswordController.text.trim()) {
      Get.snackbar('Password Mismatch', 'Password and confirm password must match.');
      return;
    }
    isLoading.value = true;
    final success = await _authService.register(
      name: registerNameController.text.trim(),
      email: registerEmailController.text.trim(),
      phone: registerPhoneController.text.trim(),
      password: registerPasswordController.text.trim(),
    );
    isLoading.value = false;
    if (!success) {
      Get.snackbar('Registration Failed', 'Please review entered details.');
      return;
    }
    loginPhoneController.text = registerPhoneController.text.trim();
    loginPasswordController.clear();
    registerPhoneController.clear();
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    Get.back<dynamic>();
    Get.snackbar('Registration Successful', 'Please login with your credentials.');
  }

  @override
  void onClose() {
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
