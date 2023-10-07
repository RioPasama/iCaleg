import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:intl/intl.dart';

class ProfileEditController extends GetxController {
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  late TextEditingController fullNameTextEditingController;
  late TextEditingController tempatLahirTextEditingController;
  late TextEditingController tanggalLahirTextEditingController;

  @override
  void onInit() {
    fullNameTextEditingController = TextEditingController();
    tanggalLahirTextEditingController = TextEditingController();
    tempatLahirTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    //
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
}
