import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/data/services/database_service.dart';
import 'package:questionnaire_app/app/data/services/location_service.dart';
import 'package:questionnaire_app/app/data/services/questionnaire_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseService(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(LocationService(), permanent: true);
    Get.put(QuestionnaireService(), permanent: true);
  }
}
