import 'package:get/get.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/app/data/models/dukungan_dpt_model.dart';
import 'package:icaleg/app/data/models/potensi_dpt_model.dart';
import 'package:icaleg/app/data/models/statistik_dapil_wilayah_model.dart';
import 'package:icaleg/app/data/services/statistics_service.dart';

class StatisticsController extends GetxController {
  UtilsController utilsController = Get.put(UtilsController());
  Rxn<PotensiDptModel> potensiDptModel = Rxn<PotensiDptModel>();
  RxList<StatistikDapilWilayahModel> statistikDapilWilayahModel =
      RxList<StatistikDapilWilayahModel>();
  Rxn<DukunganDptModel> dukunganDptModel = Rxn<DukunganDptModel>();

  String dateTimeNow = DateTime.now().toString();

  @override
  void onInit() {
    getDataDukunganDpt();
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

  Future<void> getDataDukunganDpt() async {
    dukunganDptModel.value = await StatisticsService.getDukunganiDPT();
  }

  Future<void> getDataPotensiDpt() async {
    potensiDptModel.value = await StatisticsService.getPotensiDPT();
  }

  Future<void> getDataDapilPerWilayaht() async {
    statistikDapilWilayahModel.value =
        await StatisticsService.getDapilPerWilayah();
  }
}
