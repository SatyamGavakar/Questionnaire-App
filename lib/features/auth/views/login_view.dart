import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/features/auth/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 74,
                        height: 74,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.lock_outline_rounded, size: 36),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Sign in to continue your surveys.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.loginPhoneController,
                              validator: controller.validatePhone,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone_outlined),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Obx(
                              () => TextFormField(
                                controller: controller.loginPasswordController,
                                validator: controller.validatePassword,
                                obscureText: !controller.isLoginPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: () => controller
                                        .isLoginPasswordVisible
                                        .toggle(),
                                    icon: Icon(
                                      controller.isLoginPasswordVisible.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: Obx(
                                () => FilledButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.login,
                                  child: controller.isLoading.value
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Text('Login'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.register),
                              child: const Text('No account? Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
