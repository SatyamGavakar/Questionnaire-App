import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/bindings/initial_binding.dart';
import 'package:questionnaire_app/app/routes/app_pages.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/core/theme/app_theme.dart';

class QuestionnaireApp extends StatelessWidget {
  const QuestionnaireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Questionnaire App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 280),
    );
  }
}
