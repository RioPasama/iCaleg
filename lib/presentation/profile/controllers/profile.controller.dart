import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    authController.getDataUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onTapLogout() {
    authController.logOut();
    if (authController.isLogin.isFalse) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
