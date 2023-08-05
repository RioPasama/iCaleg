import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:image_picker/image_picker.dart';

class SupportInputController extends GetxController {
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  final ImagePicker _picker = ImagePicker();

  TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();

  late TextEditingController fullNameTextEditingController;
  late TextEditingController nikTextEditingController;
  late TextEditingController tempatLahirTextEditingController;
  late TextEditingController tanggalLahirTextEditingController;
  late TextEditingController jenisKelaminTextEditingController;
  late TextEditingController alamatTextEditingController;
  late TextEditingController agamaTextEditingController;
  late TextEditingController statusPerkawinanTextEditingController;
  late TextEditingController pekerjaanTextEditingController;

  late InputImage inputImage;

  RxBool isOpenCam = true.obs;
  RxString? pathPhoto = ''.obs;
  RxString? pathIdenti = ''.obs;

  XFile? photo;
  XFile? identi;

  final formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    fullNameTextEditingController = TextEditingController();
    nikTextEditingController = TextEditingController();
    tempatLahirTextEditingController = TextEditingController();
    tanggalLahirTextEditingController = TextEditingController();
    jenisKelaminTextEditingController = TextEditingController();
    alamatTextEditingController = TextEditingController();
    agamaTextEditingController = TextEditingController();
    statusPerkawinanTextEditingController = TextEditingController();
    pekerjaanTextEditingController = TextEditingController();
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
    jenisKelaminTextEditingController.dispose();
    alamatTextEditingController.dispose();
    agamaTextEditingController.dispose();
    statusPerkawinanTextEditingController.dispose();
    pekerjaanTextEditingController.dispose();
    textRecognizer.close();
    super.onClose();
  }

  Future<void> getTextRecognizer() async {
    inputImage = InputImage.fromFilePath(pathIdenti?.value ?? '');
    RecognizedText result = await textRecognizer.processImage(inputImage);

    for (TextBlock block in result.blocks) {
      print(block.text);
      for (TextLine line in block.lines) {
        print(line.text);
        for (TextElement element in line.elements) {
          print(element.text);
        }
      }
    }
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
      await getTextRecognizer();
      isOpenCam.value = false;
      Get.back();
    }
  }
}
