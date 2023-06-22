import 'package:get/get.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  UtilsController utilsController = Get.put(UtilsController());

  @override
  void onInit() async {
    await utilsController.checkConnection();
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(Routes.LOGIN);
    });
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
}
