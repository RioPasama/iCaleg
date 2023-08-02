import 'package:get/get.dart';

import '../../../../presentation/support/controllers/support.controller.dart';

class SupportControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportController>(
      () => SupportController(),
    );
  }
}
