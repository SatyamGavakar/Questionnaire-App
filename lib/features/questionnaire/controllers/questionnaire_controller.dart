import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';
import 'package:questionnaire_app/app/data/models/submission_model.dart';
import 'package:questionnaire_app/app/data/services/database_service.dart';
import 'package:questionnaire_app/app/data/services/location_service.dart';

class QuestionnaireController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final LocationService _locationService = Get.find<LocationService>();

  late final QuestionnaireModel questionnaire;
  final selectedAnswers = <String, String>{}.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments as QuestionnaireModel;
  }

  void selectAnswer(String questionId, String answer) {
    selectedAnswers[questionId] = answer;
  }

  bool get isComplete =>
      selectedAnswers.length == questionnaire.questions.length;

  Future<void> submit() async {
    if (!isComplete) {
      Get.snackbar('Incomplete', 'Please answer all questions before submit.');
      return;
    }

    try {
      isSubmitting.value = true;
      final position = await _locationService.getCurrentPosition();
      final submission = SubmissionModel(
        questionnaireId: questionnaire.id,
        dateTime: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
      );
      await _databaseService.insertSubmission(submission);
      Get.back<dynamic>();
      Get.snackbar('Success', 'Submission saved locally.');
    } catch (e) {
      Get.snackbar('Submission Failed', e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
