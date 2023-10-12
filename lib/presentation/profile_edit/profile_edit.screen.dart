import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import 'controllers/profile_edit.controller.dart';

class ProfileEditScreen extends GetView<ProfileEditController> {
  const ProfileEditScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDefault(title: 'Edit Profile'),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: 28, left: marginHorizontal, right: marginHorizontal),
          child: Form(
            key: controller.formkey,
            child: Column(
              children: [
                Obx(
                  () => InkWell(
                    onTap: () => Get.bottomSheet(_bottomSheetPhoto()),
                    child: (controller.pathPhoto?.value == '')
                        ? ImageNetworkView(
                            url: Get.arguments['foto'],
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: colorGray, shape: BoxShape.circle),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              child: const Icon(
                                Ionicons.create_outline,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        FileImage(File(controller.photo!.path)),
                                    fit: BoxFit.cover)),
                          ),
                  ),
                ),
                const SizedBox(height: 40),
                textFromFiled(
                  controller: controller.fullNameTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Isi Nama Lengkap',
                  validator: (val) => controller.textInputValidatorController
                      .validatorFullName(val),
                ),
                const SizedBox(height: 20),
                textFromFiled(
                  controller: controller.tempatLahirTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Isi Tempat Lahir',
                  validator: (val) => controller.textInputValidatorController
                      .validatorNotNull(val),
                ),
                const SizedBox(height: 20),
                textFromFiled(
                  controller: controller.tanggalLahirTextEditingController,
                  readOnly: true,
                  onTap: () => controller.showDialogDatePicker(context),
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Isi Tanggal Lahir',
                  validator: (val) => controller.textInputValidatorController
                      .validatorNotNull(val),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () => controller.onTapSaveChange(),
                      child: const Text("Simpan Perubahan")),
                )
              ],
            ),
          ),
        ));
  }

  Container _bottomSheetPhoto() {
    return Container(
      height: 140,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          ListTile(
              leading: const Icon(Ionicons.camera_outline),
              title: const Text('Kamera'),
              onTap: () async =>
                  controller.getPhoto(source: ImageSource.camera)),
          ListTile(
              leading: const Icon(Ionicons.image_outline),
              title: const Text('Galeri'),
              onTap: () async =>
                  controller.getPhoto(source: ImageSource.gallery)),
        ],
      ),
    );
  }
}
