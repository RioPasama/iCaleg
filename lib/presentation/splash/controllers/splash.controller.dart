import 'package:get/get.dart';
import 'package:icaleg/app/controllers/app_setting_controller.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  AppSettingController appSettingController = Get.put(AppSettingController());
  AuthController authController = Get.put(AuthController());
  UtilsController utilsController = Get.put(UtilsController());

  @override
  void onInit() async {
    await utilsController.checkConnection();
    authController.getDataToken();
    authController.getDataUser();
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 4), () async {
      if (authController.isLogin.value) {
        await appSettingController.initColor();
        await Get.forceAppUpdate();
        Get.offAllNamed(Routes.MAIN);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });

    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
