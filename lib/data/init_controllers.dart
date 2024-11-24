import 'package:flutter_test_project/screens/main_screen/main_screen_controller.dart';
import 'package:get/get.dart';

/// Initialize all controllers
Future<void> initControllers() async {
  Get.put(MainScreenController());
}
