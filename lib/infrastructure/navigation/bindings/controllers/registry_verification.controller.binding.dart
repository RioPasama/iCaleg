import 'package:get/get.dart';

import '../../../../presentation/registry_verification/controllers/registry_verification.controller.dart';

class RegistryVerificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistryVerificationController>(
      () => RegistryVerificationController(),
    );
  }
}
