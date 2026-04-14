import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/submission_model.dart';
import 'package:questionnaire_app/app/data/services/auth_service.dart';
import 'package:questionnaire_app/app/data/services/database_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final DatabaseService _databaseService = Get.find<DatabaseService>();

  final submissions = <SubmissionModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadSubmissions();
  }

  Future<void> loadSubmissions() async {
    isLoading.value = true;
    submissions.assignAll(await _databaseService.fetchSubmissions());
    isLoading.value = false;
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
