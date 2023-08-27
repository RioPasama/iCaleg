import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/data_koordinator_model.dart';
import 'package:icaleg/app/data/models/voter_dukungan_model.dart';
import 'package:icaleg/app/data/services/pemilu_service.dart';
import 'package:icaleg/app/data/services/voter_service.dart';

class SupportController extends GetxController {
  AuthController authController = Get.put(AuthController());

  RxList<VoterDukunganModel> voterDukunganModel = RxList<VoterDukunganModel>();

  late TextEditingController search;

  RxBool isLoadVoterDukungan = true.obs;

  @override
  void onInit() {
    //
    super.onInit();
  }

  @override
  void onReady() {
    search = TextEditingController();
    getDukungan();
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> getDukungan() async {
    voterDukunganModel.value = await VoterService.getVoterDukungan();
    isLoadVoterDukungan.value = false;
  }

  Future<void> getKoorLap({required String tag}) async {
    List<DataKoordinatorModel> dataKoordinatorModel =
        await PemiluService.getDataKoorlap();
  }
}
