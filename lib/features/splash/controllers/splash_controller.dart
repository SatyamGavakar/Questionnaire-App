import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    await _authService.loadSession();
    if (_authService.isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
