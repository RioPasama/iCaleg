import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/home_model.dart';
import 'package:icaleg/app/data/services/home_service.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.put(AuthController());
  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  @override
  void onInit() {
    authController.getDataUser();
    fetchHome();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  void onTapLogout() {
    authController.logOut();
    if (authController.isLogin.isFalse) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> fetchHome() async {
    homeModel.value = await HomeService.getHome();
  }
}
