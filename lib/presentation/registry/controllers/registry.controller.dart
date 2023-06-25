import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:image_picker/image_picker.dart';

class RegistryController extends GetxController {
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  final ImagePicker _picker = ImagePicker();

  late TextEditingController fullNameTextEditingController;
  late TextEditingController nikTextEditingController;
  late TextEditingController numberPhoneTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController addressTextEditingController;

  RxString? pathPhoto = ''.obs;
  RxString? pathIdenti = ''.obs;
  XFile? photo;
  XFile? identi;

  @override
  void onInit() {
    fullNameTextEditingController = TextEditingController();
    nikTextEditingController = TextEditingController();
    numberPhoneTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
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
    numberPhoneTextEditingController.dispose();
    emailTextEditingController.dispose();
    addressTextEditingController.dispose();
    super.onClose();
  }

  Future<void> getPhoto({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source);
    pathPhoto!.value = image!.path;
    photo = image;
    Get.back();
  }

  Future<void> getIdenti({required ImageSource source}) async {
    var image = await _picker.pickImage(source: source);
    pathIdenti!.value = image!.path;
    identi = image;
    Get.back();
  }
}
