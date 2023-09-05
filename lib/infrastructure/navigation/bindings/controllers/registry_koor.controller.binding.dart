import 'package:get/get.dart';

import '../../../../presentation/registry_koor/controllers/registry_koor.controller.dart';

class RegistryKoorControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistryKoorController>(
      () => RegistryKoorController(),
    );
  }
}
