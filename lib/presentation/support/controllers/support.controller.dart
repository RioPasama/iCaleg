import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/data_koordinator_model.dart';
import 'package:icaleg/app/data/models/voter_dukungan_model.dart';
import 'package:icaleg/app/data/services/pemilu_service.dart';
import 'package:icaleg/app/data/services/voter_service.dart';
import 'package:icaleg/app/views/views/loading_view.dart';

class SupportController extends GetxController {
  AuthController authController = Get.put(AuthController());

  RxList<VoterDukunganModel> voterDukunganModel = RxList<VoterDukunganModel>();
  RxList<DataKoordinatorModel> dataKoordinatorKorcamModel =
      RxList<DataKoordinatorModel>();
  RxList<DataKoordinatorModel> dataKoordinatorKordesModel =
      RxList<DataKoordinatorModel>();
  RxList<DataKoordinatorModel> dataKoordinatorKordusModel =
      RxList<DataKoordinatorModel>();
  RxList<DataKoordinatorModel> dataKoordinatorKortepModel =
      RxList<DataKoordinatorModel>();

  late TextEditingController search;

  RxBool isLoadVoterDukungan = true.obs;
  RxBool isLoadVoterKorcam = true.obs;
  RxBool isLoadVoterKordes = true.obs;
  RxBool isLoadVoterKordus = true.obs;
  RxBool isLoadVoterKortep = true.obs;

  @override
  void onInit() {
    search = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    getDukungan();
    dataKoordinatorKorcamModel.value = await getKoorLap(tag: 'korcam');
    dataKoordinatorKordesModel.value = await getKoorLap(tag: 'kordes');
    dataKoordinatorKordusModel.value = await getKoorLap(tag: 'kordus');
    dataKoordinatorKortepModel.value = await getKoorLap(tag: 'kortep');
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> onTapSearch({required String tag}) async {
    Get.dialog(loadingDefault(), barrierDismissible: false);
    switch (tag) {
      case '0':
        await getDukungan();
        break;
      case '2':
        dataKoordinatorKorcamModel.value = await getKoorLap(tag: 'korcam');
        break;
      case '3':
        dataKoordinatorKordesModel.value = await getKoorLap(tag: 'kordes');
        break;
      case '4':
        dataKoordinatorKordusModel.value = await getKoorLap(tag: 'kordus');
        break;
      case '5':
        dataKoordinatorKortepModel.value = await getKoorLap(tag: 'kortep');
        break;
      default:
    }
    search.text = '';
    Get.back();
  }

  Future<void> getDukungan() async {
    // isLoadVoterDukungan.value = true;
    voterDukunganModel.value =
        await VoterService.getVoterDukungan(q: search.text);
    isLoadVoterDukungan.value = false;
  }

  Future<List<DataKoordinatorModel>> getKoorLap({required String tag}) async {
    // isLoadVoterKorcam.value = true;
    // isLoadVoterKordes.value = true;
    // isLoadVoterKordus.value = true;
    // isLoadVoterKortep.value = true;
    List<DataKoordinatorModel> dataKoordinatorModel =
        await PemiluService.getDataKoorlap(filter: tag, q: search.text);
    isLoadVoterKorcam.value = false;
    isLoadVoterKordes.value = false;
    isLoadVoterKordus.value = false;
    isLoadVoterKortep.value = false;

    return dataKoordinatorModel;
  }
}
