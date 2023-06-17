import 'package:get/get.dart';

import '../../../../presentation/main/controllers/main.controller.dart';

class MainControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
  }
}
