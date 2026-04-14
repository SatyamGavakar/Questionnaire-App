import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';
import 'package:questionnaire_app/app/data/models/submission_model.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/data/services/database_service.dart';
import 'package:questionnaire_app/app/data/services/questionnaire_service.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final QuestionnaireService _questionnaireService =
      Get.find<QuestionnaireService>();

  final selectedTab = 0.obs;
  final questionnaires = <QuestionnaireModel>[].obs;
  final submissions = <SubmissionModel>[].obs;
  final isLoadingSubmissions = false.obs;

  @override
  void onInit() {
    super.onInit();
    questionnaires.assignAll(_questionnaireService.getQuestionnaires());
    loadSubmissions();
  }

  void openQuestionnaire(QuestionnaireModel questionnaire) {
    Get.toNamed<dynamic>(AppRoutes.questionnaire, arguments: questionnaire)
        ?.then((_) => loadSubmissions());
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index != 0) {
      loadSubmissions();
    }
  }

  Future<void> loadSubmissions() async {
    isLoadingSubmissions.value = true;
    submissions.assignAll(await _databaseService.fetchSubmissions());
    isLoadingSubmissions.value = false;
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  String get userName {
    final user = _authService.currentUser.value;
    if (user == null || user.name.isEmpty) return 'User';
    return user.name;
  }

  String get userPhone {
    final user = _authService.currentUser.value;
    if (user == null) return '-';
    return user.phone.isNotEmpty ? user.phone : user.email;
  }
}
