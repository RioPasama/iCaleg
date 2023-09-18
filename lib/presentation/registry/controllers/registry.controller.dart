import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/app/data/models/address_model.dart';
import 'package:icaleg/app/data/models/dapil_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';
import 'package:icaleg/app/data/models/partai_model.dart';
import 'package:icaleg/app/data/services/address_service.dart';
import 'package:icaleg/app/data/services/pemilu_service.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegistryController extends GetxController {
  final UtilsController utilsController = Get.put(UtilsController());

  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  final ImagePicker _picker = ImagePicker();
  final formkey = GlobalKey<FormState>();

  late TextEditingController fullNameTextEditingController;
  late TextEditingController nikTextEditingController;
  late TextEditingController numberPhoneTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController addressTextEditingController;
  late TextEditingController kataSandiTextEditingController;
  late TextEditingController konformasiKataSandiTextEditingController;
  late TextEditingController referalCodeTextEditingController;
  late TextEditingController tempatLahirTextEditingController;
  late TextEditingController tpsTextEditingController;
  late TextEditingController tanggalLahirTextEditingController;

  RxList<String> gender = ['Laki - Laki', 'Perempuan'].obs;
  RxList<String> religion =
      ['islam', 'kristen', 'katholik', 'budha', 'hindu', 'khonghucu'].obs;
  RxList<String> statusPerkawinan = [
    'Belum Kawin',
    'Kawin',
    'Cerai Hidup',
    'Cerai Mati',
  ].obs;

  RxList<AddressModel> addressProvince = RxList<AddressModel>();
  RxList<AddressModel> addressRegency = RxList<AddressModel>();
  RxList<AddressModel> addressDistrict = RxList<AddressModel>();
  RxList<AddressModel> addressVillage = RxList<AddressModel>();
  RxList<DapilModel> dapilModel = RxList<DapilModel>();
  RxList<PartaiModel> partaiModel = RxList<PartaiModel>();
  RxList<LevelModel> levelModel = RxList<LevelModel>();
  RxList<LevelModel> roleModel = RxList<LevelModel>();
  RxList<LevelModel> job = RxList<LevelModel>();
  Rxn<AddressModel> selectProvince = Rxn<AddressModel>();
  Rxn<AddressModel> selectRegency = Rxn<AddressModel>();
  Rxn<AddressModel> selectDistrict = Rxn<AddressModel>();
  Rxn<AddressModel> selectVillage = Rxn<AddressModel>();
  Rxn<DapilModel> selectDapil = Rxn<DapilModel>();
  Rxn<PartaiModel> selectPartai = Rxn<PartaiModel>();
  Rxn<LevelModel> selectLevel = Rxn<LevelModel>();
  Rxn<LevelModel> selectRole = Rxn<LevelModel>();
  Rxn<LevelModel> selectJob = Rxn<LevelModel>();

  RxString? selectReligion = 'Islam'.obs;
  RxString? selectGender = 'Laki - Laki'.obs;
  RxString selectStatusPerkawinan = 'Belum Kawin'.obs;

  RxString? pathPhoto = ''.obs;
  RxString? pathIdenti = ''.obs;

  XFile? photo;
  XFile? identi;

  RxBool obscureKataSandi = true.obs;
  RxBool obscureKonfirmasiKataSandi = true.obs;

  @override
  void onInit() {
    tempatLahirTextEditingController = TextEditingController();
    fullNameTextEditingController = TextEditingController();
    nikTextEditingController = TextEditingController();
    numberPhoneTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    kataSandiTextEditingController = TextEditingController();
    konformasiKataSandiTextEditingController = TextEditingController();
    referalCodeTextEditingController = TextEditingController();
    tanggalLahirTextEditingController = TextEditingController();
    tpsTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    await fetchData();
    super.onReady();
  }

  @override
  void onClose() {
    fullNameTextEditingController.dispose();
    nikTextEditingController.dispose();
    tempatLahirTextEditingController.dispose();
    numberPhoneTextEditingController.dispose();
    emailTextEditingController.dispose();
    addressTextEditingController.dispose();
    kataSandiTextEditingController.dispose();
    konformasiKataSandiTextEditingController.dispose();
    referalCodeTextEditingController.dispose();
    tanggalLahirTextEditingController.dispose();
    tpsTextEditingController.dispose();
    super.onClose();
  }

  Future<void> showDialogDatePicker(BuildContext context) async {
    final currentDate = DateTime.now();
    final minimumDate = currentDate
        .subtract(const Duration(days: 17 * 365)); // 17 tahun ke belakang
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: minimumDate,
      firstDate: DateTime(1900),
      lastDate: minimumDate,
      initialDatePickerMode: DatePickerMode.year,
    );

    tanggalLahirTextEditingController.text =
        DateFormat('yyyy-MM-dd').format(selectedDate!);
  }

  Future<List<DapilModel>> fetchDapil({required LevelModel? levelModel}) async {
    Get.dialog(loadingDefault(), barrierDismissible: false);
    selectLevel.value = levelModel;
    selectDapil.value = null;
    dapilModel.value = [];
    List<DapilModel> result =
        await PemiluService.getDapil(status: levelModel?.status ?? '');
    dapilModel.value = result;
    Get.back();
    return result;
  }

  Future<List<AddressModel>> fetchAddress(
      {required String urlPath, String? id}) async {
    List<AddressModel> result =
        await AddressService.getAddress(urlPath: urlPath, id: id);
    return result;
  }

  Future<void> fetchData() async {
    Get.dialog(loadingDefault(), barrierDismissible: false);
    partaiModel.value = await PemiluService.getPartai();
    levelModel.value = await PemiluService.getLevel();
    roleModel.value = await UserService.getRole();
    addressProvince.value = await fetchAddress(urlPath: 'province');

    job.value = await PemiluService.getJob();
    for (LevelModel dataJob in job) {
      selectJob.value = dataJob;
    }
    Get.back();
  }

  Future<void> onChangedDropdownAddress(AddressModel? val,
      {required String tag}) async {
    Get.dialog(loadingDefault(), barrierDismissible: false);
    switch (tag) {
      case 'province':
        selectProvince.value = val;
        selectRegency.value = null;
        selectDistrict.value = null;
        selectVillage.value = null;
        addressDistrict.value = [];
        addressVillage.value = [];
        addressRegency.value = [];
        addressRegency.value =
            await fetchAddress(urlPath: 'regency', id: val?.id);
        break;
      case 'regency':
        selectRegency.value = val;
        selectDistrict.value = null;
        selectVillage.value = null;
        addressVillage.value = [];
        addressDistrict.value = [];
        addressDistrict.value =
            await fetchAddress(urlPath: 'district', id: val?.id);
        break;
      case 'district':
        selectDistrict.value = val;
        selectVillage.value = null;
        addressVillage.value = [];
        addressVillage.value =
            await fetchAddress(urlPath: 'village', id: val?.id);
        break;
      case 'village':
        selectVillage.value = val;
      default:
        Get.dialog(dialogView(
          title: 'Error wilaya',
          content: 'Wilaya belum di buat',
          onTapOke: () => Get.back(),
        ));
    }
    Get.back();
  }

  Future<void> getPhoto({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source, imageQuality: 20);
    pathPhoto!.value = image?.path ?? '';
    photo = image;
    Get.back();
  }

  Future<void> getIdenti({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source, imageQuality: 20);
    pathIdenti!.value = image?.path ?? '';
    identi = image;
    Get.back();
  }

  Future<void> onTapRegistry() async {
    if (!formkey.currentState!.validate() || photo == null || identi == null) {
      return;
    }

    int code = await UserService.postRegister(
      emial: emailTextEditingController.text,
      password: konformasiKataSandiTextEditingController.text,
      name: fullNameTextEditingController.text,
      nik: nikTextEditingController.text,
      phone: '+62${numberPhoneTextEditingController.text}',
      fkProvince: selectProvince.value!.id,
      fkRegency: selectRegency.value!.id,
      fkDistrict: selectDistrict.value!.id,
      fkVillage: selectVillage.value!.id,
      address: addressTextEditingController.text,
      levelPemilihan: selectLevel.value!.status,
      userStatus: int.parse(selectRole.value!.id),
      gender: (selectGender!.value == 'Perempuan') ? 'Female' : 'Male',
      religion: selectReligion!.value,
      fkDapil: selectDapil.value!.id,
      birthday: tanggalLahirTextEditingController.text,
      born: tempatLahirTextEditingController.text,
      fkPartai: selectPartai.value!.id,
      job: selectJob.value!.name,
      tps: tpsTextEditingController.text,
      referalCode: referalCodeTextEditingController.text,
      photoIdentity: File(photo!.path),
      photoKTP: File(identi!.path),
      statusKawin: (selectStatusPerkawinan.value == 'Belum Kawin')
          ? '1'
          : (selectStatusPerkawinan.value == 'Kawin')
              ? '2'
              : (selectStatusPerkawinan.value == 'Cerai Hidup')
                  ? '3'
                  : '4',
    );

    if (code == 200) {
      Get.toNamed(Routes.REGISTRY_VERIFICATION,
          arguments: '+62${numberPhoneTextEditingController.text}');
    }
  }
}
