import 'package:get/get.dart';

import '../../../../presentation/support_input/controllers/support_input.controller.dart';

class SupportInputControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportInputController>(
      () => SupportInputController(),
    );
  }
}
