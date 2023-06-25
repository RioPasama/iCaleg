import 'package:get/get.dart';

import '../../../../presentation/privacy_policy/controllers/privacy_policy.controller.dart';

class PrivacyPolicyControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(
      () => PrivacyPolicyController(),
    );
  }
}
