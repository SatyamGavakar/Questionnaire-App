import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';
import 'package:questionnaire_app/app/data/models/submission_model.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/data/services/database_service.dart';
import 'package:questionnaire_app/app/data/services/questionnaire_service.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/core/utils/app_snackbar.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final QuestionnaireService _questionnaireService =
      Get.find<QuestionnaireService>();

  final selectedTab = 0.obs;
  final questionnaires = <QuestionnaireModel>[].obs;
  final submissions = <SubmissionModel>[].obs;
  final submittedQuestionnaireIds = <String>{}.obs;
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

  void openSubmittedQuestionnaire(QuestionnaireModel questionnaire) {
    final submission = submissions.firstWhereOrNull(
      (item) => item.questionnaireId == questionnaire.id,
    );
    if (submission == null) {
      AppSnackbar.error(
        'Submission Not Found',
        'Could not find submitted answers for this questionnaire.',
      );
      return;
    }
    openSubmissionReview(questionnaire: questionnaire, submission: submission);
  }

  void openSubmissionReview({
    required QuestionnaireModel questionnaire,
    required SubmissionModel submission,
  }) {
    Get.toNamed<dynamic>(
      AppRoutes.submissionDetails,
      arguments: {
        'questionnaire': questionnaire,
        'submission': submission,
      },
    );
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index != 0) {
      loadSubmissions();
    }
  }

  Future<void> loadSubmissions() async {
    isLoadingSubmissions.value = true;
    final userId = _authService.currentUser.value?.id;
    submissions.assignAll(await _databaseService.fetchSubmissions(userId: userId));
    submittedQuestionnaireIds.assignAll(
      submissions.map((e) => e.questionnaireId).toSet(),
    );
    isLoadingSubmissions.value = false;
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> confirmLogout() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back<bool>(result: false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Get.back<bool>(result: true),
            child: const Text('Logout'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (result == true) {
      await logout();
    }
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

  String get userEmail {
    final user = _authService.currentUser.value;
    if (user == null || user.email.isEmpty) return '-';
    return user.email;
  }
}
