import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/data/models/Koorlap_tps_model.dart';
import 'package:icaleg/app/data/services/address_service.dart';
import 'package:icaleg/app/data/services/pemilu_service.dart';
import 'package:icaleg/app/data/services/voter_service.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';
// import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'dart:async';
import 'package:icaleg/app/data/models/address_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class SupportInputController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  final ImagePicker _picker = ImagePicker();

  late TextEditingController fullNameTextEditingController;
  late TextEditingController tpsTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController nikTextEditingController;
  late TextEditingController tempatLahirTextEditingController;
  late TextEditingController tanggalLahirTextEditingController;
  late TextEditingController numberPhoneTextEditingController;
  late TextEditingController alamatTextEditingController;

  late Position position;

  RxList<AddressModel> addressProvince = RxList<AddressModel>();
  RxList<AddressModel> addressRegency = RxList<AddressModel>();
  RxList<AddressModel> addressDistrict = RxList<AddressModel>();
  RxList<AddressModel> addressVillage = RxList<AddressModel>();
  RxList<LevelModel> religion = RxList<LevelModel>();
  RxList<KoorlapTpsModel> koorlapTps = RxList<KoorlapTpsModel>();
  RxList<LevelModel> job = RxList<LevelModel>();
  Rxn<AddressModel> selectProvince = Rxn<AddressModel>();
  Rxn<AddressModel> selectRegency = Rxn<AddressModel>();
  Rxn<AddressModel> selectDistrict = Rxn<AddressModel>();
  Rxn<AddressModel> selectVillage = Rxn<AddressModel>();
  Rxn<LevelModel> selectReligion = Rxn<LevelModel>();
  Rxn<LevelModel> selectJob = Rxn<LevelModel>();
  Rxn<KoorlapTpsModel> selectKoorlapTps = Rxn<KoorlapTpsModel>();
  RxString selectGender = 'Laki - Laki'.obs;
  RxString selectStatusPerkawinan = 'Belum Kawin'.obs;

  late NIKModel dataNIKKTP;

  bool isScan = Get.arguments ?? false;
  RxBool isLoaded = false.obs;
  RxBool isEmty = false.obs;
  RxBool isOpenCam = true.obs;
  RxBool isInputTPS = false.obs;
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
    tpsTextEditingController = TextEditingController();
    fullNameTextEditingController = TextEditingController();
    nikTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    tempatLahirTextEditingController = TextEditingController();
    tanggalLahirTextEditingController = TextEditingController();
    numberPhoneTextEditingController = TextEditingController();
    alamatTextEditingController = TextEditingController();
    if (isScan) {
      scanKtp(isInitValuerKTP: true);
    }
    _determinePosition();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tpsTextEditingController.dispose();
    fullNameTextEditingController.dispose();
    nikTextEditingController.dispose();
    emailTextEditingController.dispose();
    tempatLahirTextEditingController.dispose();
    tanggalLahirTextEditingController.dispose();
    numberPhoneTextEditingController.dispose();
    alamatTextEditingController.dispose();
    super.onClose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // _determinePosition();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // _determinePosition();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
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
        Get.back();
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
        Get.back();
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
        Get.back();
        selectByName(
            addressList: addressRegency,
            compareName: ktpRes?.ktp?.kelurahan ?? '',
            tag: 'village');
        break;
      case 'village':
        selectVillage.value = val;
        Get.back();
      default:
        Get.dialog(dialogView(
          title: 'Error wilaya',
          content: 'Wilaya belum di buat',
          onTapOke: () => Get.back(),
        ));
    }
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

  Future<void> scanKtp({required bool isInitValuerKTP}) async {
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
    if (isInitValuerKTP) {
      initValuerKTP(data: res);
    }

    isOpenCam.value = false;
    pathIdenti?.value = res?.imagePath ?? '';
    await initValueKTP();
    await fetchData();
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
    var image = await _picker.pickImage(source: source, imageQuality: 20);
    pathPhoto!.value = image?.path ?? '';
    photo = image;
    Get.back();
  }

  Future<void> onNext() async {
    if (!formkey.currentState!.validate() ||
        pathPhoto?.value == null ||
        pathIdenti?.value == null) {
      return;
    }

    if (authController.userModel.userStatus == '5') {
      onTapRegistry();
    } else {
      isInputTPS.value = true;
    }
  }

  Future<void> onTapGetKoorlapTPS() async {
    isLoaded.value = true;
    koorlapTps.value = await PemiluService.getKoorlapTps(
        tps: tpsTextEditingController.text, fkVillage: selectVillage.value!.id);
    isLoaded.value = false;
    isEmty.value = koorlapTps.isEmpty;
  }

  Future<void> getIdenti({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source, imageQuality: 20);
    pathIdenti!.value = image?.path ?? '';
    identi = image;
    await fetchData();
    // await initValueKTP();

    // Get.back();
  }

  Future<void> onTapRegistry() async {
    if (authController.userModel.userStatus != '5') {
      if (selectKoorlapTps.value?.id.isEmpty ?? true) {
        Get.dialog(dialogView(
          title: 'Data Kurang Lengkap',
          content: 'Isikan Nomor TPS dan  Piih KoorLapnya',
          onTapOke: () => Get.back(),
        ));
      }
    }
    int code = await VoterService.postVoterDukungan(
      nik: nikTextEditingController.text,
      name: fullNameTextEditingController.text,
      gender: (selectGender.value == 'Laki - Laki') ? 'male' : 'female',
      phone: '+62${numberPhoneTextEditingController.text}',
      email: emailTextEditingController.text,
      born: tempatLahirTextEditingController.text,
      birthday: tanggalLahirTextEditingController.text,
      fkProvince: selectProvince.value!.id,
      fkRegency: selectRegency.value!.id,
      fkDistrict: selectDistrict.value!.id,
      fkVillage: selectVillage.value!.id,
      photoIdentity: File(pathPhoto!.value),
      photoKTP: File(pathIdenti!.value),
      job: selectJob.value!.name,
      religion: selectReligion.value!.name,
      lat: position.altitude,
      lng: position.longitude,
      tps: tpsTextEditingController.text,
      address: alamatTextEditingController.text,
      fkKortep: selectKoorlapTps.value?.id ?? '0',
      statusKawin: (selectStatusPerkawinan.value == 'Belum Kawin')
          ? '1'
          : (selectStatusPerkawinan.value == 'Kawin')
              ? '2'
              : (selectStatusPerkawinan.value == 'Cerai Hidup')
                  ? '3'
                  : '4',
    );

    if (code == 200) {
      dialogView(
        title: 'Berhasil',
        content:
            'Data ${fullNameTextEditingController.text} berhasil di simpan',
        onTapOke: () => Get.offAllNamed(Routes.MAIN),
      );
    }
  }
}
