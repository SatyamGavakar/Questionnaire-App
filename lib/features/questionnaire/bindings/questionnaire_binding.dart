import 'package:get/get.dart';
import 'package:questionnaire_app/features/questionnaire/controllers/questionnaire_controller.dart';

class QuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(QuestionnaireController.new);
  }
}
