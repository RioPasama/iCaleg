import 'package:get/get.dart';

import '../../../../presentation/registry/controllers/registry.controller.dart';

class RegistryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistryController>(
      () => RegistryController(),
    );
  }
}
