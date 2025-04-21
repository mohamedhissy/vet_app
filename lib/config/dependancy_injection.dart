import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/storage/local/database/shared_preferences/app_settings_shared_preferences.dart';
import '../features/home/presentation/controller/home_controller.dart';

initModule() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsSharedPreferences().initPreferences();
}


initHome() {
  Get.put<HomeController>(HomeController());
}

disposeHome() {

}
//
// initQuestion() {
//   Get.put<QuestionController>(QuestionController());
// }
//
// disposeQuestion() {
//
// }
//

