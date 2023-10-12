import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/app/data/models/home_model.dart';
import 'package:icaleg/app/data/services/home_service.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.put(AuthController());
  UtilsController utilsController = Get.put(UtilsController());
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

  void onTapEditProfile() {
    Map<String, dynamic> sendArguments = {
      'foto': authController.userModel.image,
      'name': authController.userModel.name,
      'born': authController.userModel.born,
      'biryhday': authController.userModel.birthday,
    };

    Get.toNamed(Routes.PROFILE_EDIT, arguments: sendArguments);
  }
}
