import 'package:get/get.dart';

import '../../../../presentation/forget_password/controllers/forget_password.controller.dart';

class ForgetPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(
      () => ForgetPasswordController(),
    );
  }
}
