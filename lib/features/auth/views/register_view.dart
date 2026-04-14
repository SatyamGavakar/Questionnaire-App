import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/features/auth/controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: controller.registerFormKey,
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
                        child: const Icon(Icons.person_add_alt_rounded, size: 36),
                      ),
                    ),
                    const SizedBox(height: 14),
                  
                    const SizedBox(height: 6),
                    Center(
                      child: Text(
                        'Register to start submitting questionnaires.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.registerNameController,
                              validator: controller.validateName,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person_outline_rounded),
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: controller.registerEmailController,
                              validator: controller.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: controller.registerPhoneController,
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
                                controller: controller.registerPasswordController,
                                validator: controller.validatePassword,
                                obscureText: !controller.isRegisterPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: () => controller
                                        .isRegisterPasswordVisible
                                        .toggle(),
                                    icon: Icon(
                                      controller.isRegisterPasswordVisible.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Obx(
                              () => TextFormField(
                                controller: controller.registerConfirmPasswordController,
                                validator: controller.validatePassword,
                                obscureText:
                                    !controller.isRegisterConfirmPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon:
                                      const Icon(Icons.verified_user_outlined),
                                  suffixIcon: IconButton(
                                    onPressed: () => controller
                                        .isRegisterConfirmPasswordVisible
                                        .toggle(),
                                    icon: Icon(
                                      controller
                                              .isRegisterConfirmPasswordVisible.value
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
                                      : controller.register,
                                  child: controller.isLoading.value
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Text('Register'),
                                ),
                              ),
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
