import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';
import 'package:questionnaire_app/app/data/models/submission_model.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/data/services/database_service.dart';
import 'package:questionnaire_app/app/data/services/location_service.dart';
import 'package:questionnaire_app/core/utils/app_snackbar.dart';

class QuestionnaireController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final LocationService _locationService = Get.find<LocationService>();

  late final QuestionnaireModel questionnaire;
  final selectedAnswers = <String, String>{}.obs;
  final isSubmitting = false.obs;
  final alreadySubmitted = false.obs;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments as QuestionnaireModel;
    _checkAlreadySubmitted();
  }

  Future<void> _checkAlreadySubmitted() async {
    final user = _authService.currentUser.value;
    if (user == null) return;
    alreadySubmitted.value = await _databaseService.hasSubmitted(
      userId: user.id,
      questionnaireId: questionnaire.id,
    );
  }

  void selectAnswer(String questionId, String answer) {
    if (alreadySubmitted.value) return;
    selectedAnswers[questionId] = answer;
  }

  bool get isComplete =>
      selectedAnswers.length == questionnaire.questions.length;

  Future<void> submit() async {
    if (!isComplete) {
      AppSnackbar.error('Incomplete', 'Please answer all questions before submit.');
      return;
    }

    final user = _authService.currentUser.value;
    if (user == null) {
      AppSnackbar.error('Not Logged In', 'Please login again.');
      return;
    }
    if (alreadySubmitted.value) {
      AppSnackbar.error(
        'Already Submitted',
        'You have already submitted this questionnaire.',
      );
      return;
    }

    try {
      isSubmitting.value = true;
      final position = await _locationService.getCurrentPosition();
      final submission = SubmissionModel(
        userId: user.id,
        questionnaireId: questionnaire.id,
        dateTime: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
        answers: Map<String, String>.from(selectedAnswers),
      );
      await _databaseService.insertSubmission(submission);
      alreadySubmitted.value = true;
      Get.back<dynamic>();
      AppSnackbar.success('Success', 'Submission saved locally.');
    } catch (e) {
      final message = e.toString();
      if (message.contains('UNIQUE') || message.contains('unique')) {
        AppSnackbar.error(
          'Already Submitted',
          'You have already submitted this questionnaire.',
        );
        alreadySubmitted.value = true;
      } else {
        AppSnackbar.error('Submission Failed', message);
      }
    } finally {
      isSubmitting.value = false;
    }
  }
}
