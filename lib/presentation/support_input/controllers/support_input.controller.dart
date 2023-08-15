import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/data/services/address_service.dart';
import 'package:icaleg/app/data/services/pemilu_service.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
// import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'dart:async';
import 'package:icaleg/app/data/models/address_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';

class SupportInputController extends GetxController {
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  final ImagePicker _picker = ImagePicker();

  late TextEditingController fullNameTextEditingController;
  late TextEditingController nikTextEditingController;
  late TextEditingController tempatLahirTextEditingController;
  late TextEditingController tanggalLahirTextEditingController;
  late TextEditingController numberPhoneTextEditingController;
  late TextEditingController alamatTextEditingController;

  RxList<AddressModel> addressProvince = RxList<AddressModel>();
  RxList<AddressModel> addressRegency = RxList<AddressModel>();
  RxList<AddressModel> addressDistrict = RxList<AddressModel>();
  RxList<AddressModel> addressVillage = RxList<AddressModel>();
  RxList<LevelModel> religion = RxList<LevelModel>();
  RxList<LevelModel> job = RxList<LevelModel>();
  Rxn<AddressModel> selectProvince = Rxn<AddressModel>();
  Rxn<AddressModel> selectRegency = Rxn<AddressModel>();
  Rxn<AddressModel> selectDistrict = Rxn<AddressModel>();
  Rxn<AddressModel> selectVillage = Rxn<AddressModel>();
  Rxn<LevelModel> selectReligion = Rxn<LevelModel>();
  Rxn<LevelModel> selectJob = Rxn<LevelModel>();
  RxString selectGender = ''.obs;
  RxString selectStatusPerkawinan = ''.obs;

  late NIKModel dataNIKKTP;

  RxBool isOpenCam = true.obs;
  RxString? pathPhoto = ''.obs;
  RxString? pathIdenti = ''.obs;
  XFile? photo;
  XFile? identi;

  final formkey = GlobalKey<FormState>();

  OcrResultModel? ktpRes;

  late String textblock;

  RxList<String> gender = ['Laki - Laki', 'Perempuan'].obs;
  RxList<String> statusPerkawinan = [
    'Belum Kawin',
    'Kawin',
    'Cerai Hidup',
    'Cerai Mati',
  ].obs;

  @override
  void onInit() {
    fullNameTextEditingController = TextEditingController();
    nikTextEditingController = TextEditingController();
    tempatLahirTextEditingController = TextEditingController();
    tanggalLahirTextEditingController = TextEditingController();
    numberPhoneTextEditingController = TextEditingController();
    alamatTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    fullNameTextEditingController.dispose();
    nikTextEditingController.dispose();
    tempatLahirTextEditingController.dispose();
    tanggalLahirTextEditingController.dispose();
    numberPhoneTextEditingController.dispose();
    alamatTextEditingController.dispose();
    super.onClose();
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
        selectByName(
            addressList: addressRegency,
            compareName: ktpRes?.ktp?.kabKot ?? dataNIKKTP.city ?? '',
            tag: 'regency');
        break;
      case 'regency':
        selectRegency.value = val;
        selectDistrict.value = null;
        selectVillage.value = null;
        addressVillage.value = [];
        addressDistrict.value = [];
        addressDistrict.value =
            await fetchAddress(urlPath: 'district', id: val?.id);
        selectByName(
            addressList: addressRegency,
            compareName: ktpRes?.ktp?.kecamatan ?? dataNIKKTP.subdistrict ?? '',
            tag: 'district');
        break;
      case 'district':
        selectDistrict.value = val;
        selectVillage.value = null;
        addressVillage.value = [];
        addressVillage.value =
            await fetchAddress(urlPath: 'village', id: val?.id);
        selectByName(
            addressList: addressRegency,
            compareName: ktpRes?.ktp?.kelurahan ?? '',
            tag: 'village');
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

  void selectByName({
    required RxList<AddressModel> addressList,
    required String compareName,
    required String tag,
  }) {
    for (AddressModel dataAddressModel in addressList) {
      if (dataAddressModel.name.toUpperCase().trim() ==
          compareName.toUpperCase().trim()) {
        if (tag != 'village') {
          onChangedDropdownAddress(dataAddressModel, tag: tag);
        }
        break;
      }
    }
  }

  Future<void> fetchData() async {
    addressProvince.value = await fetchAddress(urlPath: 'province');
    religion.value = await PemiluService.getReligion();
    job.value = await PemiluService.getJob();

    print('Data KTP Provinsi  ${ktpRes?.ktp?.provinsi} ${dataNIKKTP.province}');
    print('Data KTP Agama  ${ktpRes?.ktp?.agama} ');

    for (AddressModel dataAddressModel in addressProvince) {
      if ([
        ktpRes?.ktp?.provinsi?.toUpperCase().trim(),
        dataNIKKTP.province?.toUpperCase().trim(),
      ].contains(dataAddressModel.name.toUpperCase().trim())) {
        selectProvince.value = dataAddressModel;
        onChangedDropdownAddress(selectProvince.value, tag: 'province');
      }
    }

    for (LevelModel dataReligion in religion) {
      if (dataReligion.name.toUpperCase().trim() ==
          (ktpRes?.ktp?.agama ?? '').toUpperCase().trim()) {
        selectReligion.value = dataReligion;
      }
    }
    for (LevelModel dataJob in job) {
      if (dataJob.name.toUpperCase().trim() ==
          (ktpRes?.ktp?.pekerjaan ?? '').toUpperCase().trim()) {
        selectJob.value = dataJob;
      }
    }
    for (String dataGender in gender) {
      if ([
        ktpRes?.ktp?.jenisKelamin?.toUpperCase().trim(),
        dataNIKKTP.gender?.toUpperCase().trim()
      ].contains(dataGender.toUpperCase().trim())) {
        selectGender.value = dataGender;
      }
    }
    for (String dataStatusPerkawinan in statusPerkawinan) {
      if (dataStatusPerkawinan.toUpperCase().trim() ==
          (ktpRes?.ktp?.statusPerkawinan ?? '').toUpperCase().trim()) {
        selectStatusPerkawinan.value = dataStatusPerkawinan;
      }
    }
  }

  Future<void> initValueKTP() async {
    dataNIKKTP = await NIKValidator.instance.parse(nik: ktpRes?.ktp?.nik ?? '');
  }

  Future<List<AddressModel>> fetchAddress(
      {required String urlPath, String? id}) async {
    List<AddressModel> result =
        await AddressService.getAddress(urlPath: urlPath, id: id);
    return result;
  }

  Future<void> scanKtp() async {
    OcrResultModel? res;
    try {
      res = await MncIdentifierOcr.startCaptureKtp(
          withFlash: true, cameraOnly: true);
      // OcrResultModel res = await MncIdentifierOcr.
      ktpRes = res;
      debugPrint('result: ${res.toString()}');
    } catch (e) {
      debugPrint('something goes wrong $e');
    }
    initValuerKTP(data: res);
    await initValueKTP();
    await fetchData();
    isOpenCam.value = false;
  }

  void initValuerKTP({OcrResultModel? data}) {
    fullNameTextEditingController.text = data?.ktp?.nama?.toUpperCase() ?? '';
    nikTextEditingController.text = data?.ktp?.nik ?? '';
    tempatLahirTextEditingController.text =
        (data?.ktp?.tempatLahir ?? ktpRes?.ktp?.tempatLahir ?? '')
            .toUpperCase();
    tanggalLahirTextEditingController.text =
        data?.ktp?.tglLahir ?? ktpRes?.ktp?.tglLahir ?? '';
    alamatTextEditingController.text =
        '${data?.ktp?.provinsi} ${data?.ktp?.alamat ?? ktpRes?.ktp?.alamat}, ${data?.ktp?.kecamatan ?? ktpRes?.ktp?.kecamatan}, RT${data?.ktp?.rt ?? ktpRes?.ktp?.rt}/RW${data?.ktp?.rw ?? ktpRes?.ktp?.rw}';
    selectGender.value =
        data?.ktp?.jenisKelamin ?? ktpRes?.ktp?.jenisKelamin ?? '';
  }

  Future<void> getPhoto({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source, imageQuality: 0);
    pathPhoto!.value = image?.path ?? '';
    photo = image;

    Get.back();
  }

  Future<void> getIdenti({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source, imageQuality: 80);
    pathIdenti!.value = image?.path ?? '';
    identi = image;

    if (pathIdenti?.value != '') {
      Get.back();
    }
  }

  Future<void> onTapRegistry() async {
    if (!formkey.currentState!.validate() || photo == null || identi == null) {
      return;
    }
  }
}
