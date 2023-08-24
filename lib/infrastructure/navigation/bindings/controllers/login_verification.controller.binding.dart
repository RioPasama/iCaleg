import 'package:get/get.dart';

import '../../../../presentation/login_verification/controllers/login_verification.controller.dart';

class LoginVerificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginVerificationController>(
      () => LoginVerificationController(),
    );
  }
}
