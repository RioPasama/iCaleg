import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

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
          child: Column(
            children: [
              ImageNetworkView(
                url: '',
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: colorGray, shape: BoxShape.circle),
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
                    onPressed: () {}, child: const Text("Simpan Perubahan")),
              )
            ],
          ),
        ));
  }
}
