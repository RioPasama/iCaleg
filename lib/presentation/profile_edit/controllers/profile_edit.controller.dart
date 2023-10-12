import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileEditController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  late TextEditingController fullNameTextEditingController;
  late TextEditingController tempatLahirTextEditingController;
  late TextEditingController tanggalLahirTextEditingController;

  final formkey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  XFile? photo;
  RxString? pathPhoto = ''.obs;

  @override
  void onInit() {
    fullNameTextEditingController = TextEditingController();
    tanggalLahirTextEditingController = TextEditingController();
    tempatLahirTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    fullNameTextEditingController.text = Get.arguments['name'];
    tempatLahirTextEditingController.text = Get.arguments['born'];
    tanggalLahirTextEditingController.text =
        DateFormat('yyyy-MM-dd').format(Get.arguments['biryhday']);
    super.onReady();
  }

  @override
  void onClose() {
    tanggalLahirTextEditingController.dispose();
    fullNameTextEditingController.dispose();
    tempatLahirTextEditingController.dispose();
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

  Future<void> onTapSaveChange() async {
    late int code;
    if (!formkey.currentState!.validate()) {
      return;
    }
    if (fullNameTextEditingController.text == Get.arguments['name'] &&
        tempatLahirTextEditingController.text == Get.arguments['born'] &&
        tanggalLahirTextEditingController.text ==
            DateFormat('yyyy-MM-dd').format(Get.arguments['biryhday']) &&
        pathPhoto?.value == '') {
      Get.dialog(dialogView(
        title: 'Perubahan',
        content: 'Tidak ada data yang diganti',
        onTapOke: () => Get.back(),
      ));
      return;
    }

    if (!(fullNameTextEditingController.text == Get.arguments['name'] &&
        tempatLahirTextEditingController.text == Get.arguments['born'] &&
        tanggalLahirTextEditingController.text ==
            DateFormat('yyyy-MM-dd').format(Get.arguments['biryhday']))) {
      code = await UserService.changeProfile(
          name: fullNameTextEditingController.text,
          born: tempatLahirTextEditingController.text,
          birthday: tanggalLahirTextEditingController.text);

      if (code != 200) {
        return;
      }
    }

    if (pathPhoto?.value != '') {
      code = await UserService.changePhotoProfile(
          photoIdentity: File(photo!.path));
      if (code != 200) {
        return;
      }
    }

    UserModel userModel = await UserService.getDataUser();
    authController.saveDataUser(userModel: userModel);
    authController.getDataUser();

    if (userModel.nik.isNotEmpty) {
      Get.offAllNamed(Routes.MAIN);
    }
  }

  Future<void> getPhoto({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source, imageQuality: 20);
    pathPhoto!.value = image?.path ?? '';
    photo = image;
    Get.back();
  }
}
