import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support_input/controllers/support_input.controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class SupportInputFormView extends GetView {
  SupportInputFormView({Key? key}) : super(key: key);
  @override
  final SupportInputController controller = Get.put(SupportInputController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
        children: [
          _buttonPhoto(
            label: 'Foto Profile',
            icon: Assets.icons.buttonPhotoPreson,
            isPhoto: true,
            path: controller.pathPhoto,
            onTap: () => Get.bottomSheet(_bottomSheetPhoto(isPhoto: true)),
          ),
          _textLabel(label: 'Nama Lengkap', subLabel: '* Wajib di isi'),
          textFromFiled(
            controller: controller.fullNameTextEditingController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Isi Nama Lengkap',
            validator: (val) =>
                controller.textInputValidatorController.validatorFullName(val),
          ),
          _textLabel(label: 'NIK', subLabel: '* Wajib di isi'),
          textFromFiled(
            controller: controller.nikTextEditingController,
            keyboardType: TextInputType.datetime,
            hintText: 'Isi NIK',
            validator: (val) =>
                controller.textInputValidatorController.validatorNIK(val),
          ),
          _textLabel(label: 'Alamat Lengkapi', subLabel: '* Wajib di isi'),
          textFromFiled(
            controller: controller.alamatTextEditingController,
            hintText:
                'Isi alamat Lengkap\nJl Seturan, RT 02 RW05 Candi asih, Sleman...',
            keyboardType: TextInputType.multiline,
            maxLines: null,
            validator: (val) =>
                controller.textInputValidatorController.validatorNotNull(val),
          ),
        ],
      ),
    );
  }

  Container _bottomSheetPhoto({required bool isPhoto}) {
    return Container(
      height: 140,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Ionicons.camera_outline),
            title: const Text('Kamera'),
            onTap: () async => (isPhoto)
                ? controller.getPhoto(source: ImageSource.camera)
                : controller.getIdenti(source: ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Ionicons.image_outline),
            title: const Text('Galeri'),
            onTap: () async => (isPhoto)
                ? controller.getPhoto(source: ImageSource.gallery)
                : controller.getIdenti(source: ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Column _buttonPhoto(
      {required String label,
      required String icon,
      required RxString? path,
      required bool isPhoto,
      required Function() onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Obx(
            () => Container(
              height: 134,
              width: 156,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 22),
              decoration: BoxDecoration(
                color: colorGray,
                borderRadius: borderRadius,
                image: (path?.value != '')
                    ? DecorationImage(
                        image: FileImage(
                          File((isPhoto)
                              ? controller.photo!.path
                              : controller.identi!.path),
                        ),
                        fit: BoxFit.cover)
                    : null,
              ),
              child: (path?.value == '') ? SvgPicture.asset(icon) : null,
            ),
          ),
        ),
        SizedBox(
          width: 156,
          child: Text(
            label,
            style:
                TextStyle(color: colorTextPrimary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Padding _textLabel({required String label, String? subLabel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                  color: colorTextPrimary, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: subLabel,
              style: TextStyle(
                  color: colorTextAlert,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
