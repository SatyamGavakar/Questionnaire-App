import 'package:get/get.dart';
import 'package:questionnaire_app/features/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
  }
}
