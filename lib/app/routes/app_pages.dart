import 'package:get/get.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/features/auth/bindings/auth_binding.dart';
import 'package:questionnaire_app/features/auth/views/login_view.dart';
import 'package:questionnaire_app/features/auth/views/register_view.dart';
import 'package:questionnaire_app/features/home/bindings/home_binding.dart';
import 'package:questionnaire_app/features/home/views/home_view.dart';
import 'package:questionnaire_app/features/profile/bindings/profile_binding.dart';
import 'package:questionnaire_app/features/profile/views/profile_view.dart';
import 'package:questionnaire_app/features/questionnaire/bindings/questionnaire_binding.dart';
import 'package:questionnaire_app/features/questionnaire/views/questionnaire_view.dart';
import 'package:questionnaire_app/features/splash/bindings/splash_binding.dart';
import 'package:questionnaire_app/features/splash/views/splash_view.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: LoginView.new,
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: RegisterView.new,
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: HomeView.new,
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.questionnaire,
      page: QuestionnaireView.new,
      binding: QuestionnaireBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: ProfileView.new,
      binding: ProfileBinding(),
    ),
  ];
}
