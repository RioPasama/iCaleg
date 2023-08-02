import 'package:get/get.dart';

import '../../../../presentation/statistics/controllers/statistics.controller.dart';

class StatisticsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsController>(
      () => StatisticsController(),
    );
  }
}
