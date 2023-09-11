import 'package:get/get.dart';
import 'package:icaleg/app/data/models/potensi_dpt_model.dart';
import 'package:icaleg/app/data/models/statistik_dapil_wilayah_model.dart';
import 'package:icaleg/app/data/services/statistics_service.dart';

class StatisticsController extends GetxController {
  Rxn<PotensiDptModel> potensiDptModel = Rxn<PotensiDptModel>();
  RxList<StatistikDapilWilayahModel> statistikDapilWilayahModel =
      RxList<StatistikDapilWilayahModel>();

  String dateTimeNow = DateTime.now().toString();

  @override
  void onInit() {
    getDataPotensiDpt();
    getDataDapilPerWilayaht();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> getDataPotensiDpt() async {
    potensiDptModel.value = await StatisticsService.getPotensiDPT();
  }

  Future<void> getDataDapilPerWilayaht() async {
    statistikDapilWilayahModel.value =
        await StatisticsService.getDapilPerWilayah();
  }
}
