import 'package:get/get.dart';

import '../../../../presentation/support_detail/controllers/support_detail.controller.dart';

class SupportDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportDetailController>(
      () => SupportDetailController(),
    );
  }
}
