import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/home_model.dart';
import 'package:icaleg/app/data/services/home_service.dart';

class HomeController extends GetxController {
  AuthController authController = Get.put(AuthController());

  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    authController.getDataUser();
    super.onInit();
  }

  @override
  void onReady() {
    fetchHome();
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> fetchHome() async {
    homeModel.value = await HomeService.getHome();
    isLoading.value = false;
  }
}
