import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/data/models/address_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _buttonPhoto(
                  label: 'Foto Profile',
                  icon: Assets.icons.buttonPhotoPreson,
                  isPhoto: true,
                  path: controller.pathPhoto,
                  onTap: () =>
                      Get.bottomSheet(_bottomSheetPhoto(isPhoto: true)),
                ),
              ),
              _textLabel(label: 'Nama Lengkap', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.fullNameTextEditingController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Isi Nama Lengkap',
                validator: (val) => controller.textInputValidatorController
                    .validatorFullName(val),
              ),
              _textLabel(label: 'NIK', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.nikTextEditingController,
                keyboardType: TextInputType.datetime,
                hintText: 'Isi NIK',
                validator: (val) =>
                    controller.textInputValidatorController.validatorNIK(val),
              ),
              _textLabel(label: 'Email', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Isi Email',
                validator: (val) => controller.textInputValidatorController
                    .validatorFullName(val),
              ),
              _textLabel(label: 'No. Telpon (WA)', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.numberPhoneTextEditingController,
                hintText: ' Isi No. Telpon (WA)',
                keyboardType: TextInputType.datetime,
                prefixIcon: Container(
                    width: 24,
                    decoration: const BoxDecoration(
                        border: Border(right: BorderSide(color: Colors.grey))),
                    alignment: Alignment.center,
                    child: const Text('+62')),
                validator: (val) => controller.textInputValidatorController
                    .validatorNumberPhone(val),
              ),
              _textLabel(label: 'Tempat Lahir', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.tempatLahirTextEditingController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Isi Tempat Lahir',
                validator: (val) => controller.textInputValidatorController
                    .validatorNotNull(val),
              ),
              _textLabel(label: 'Tanggal Lahir', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.tanggalLahirTextEditingController,
                readOnly: true,
                onTap: () => controller.showDialogDatePicker(context),
                keyboardType: TextInputType.emailAddress,
                hintText: 'Isi Tanggal Lahir',
                validator: (val) => controller.textInputValidatorController
                    .validatorNotNull(val),
              ),
              _textLabel(label: 'Agama', subLabel: '* Wajib di isi'),
              _dropdownReligion(
                  data: controller.religion, select: controller.selectReligion),
              _textLabel(
                  label: 'Status Perkawinan', subLabel: '* Wajib di isi'),
              _dropdownStatusPerkawinan(data: controller.statusPerkawinan),
              _textLabel(label: 'Pekerjaan', subLabel: '* Wajib di isi'),
              _dropdownJob(data: controller.job, select: controller.selectJob),
              _textLabel(label: 'Jenis Kelamin', subLabel: '* Wajib di isi'),
              _dropdownGender(
                  data: controller.gender, select: controller.selectGender),
              _textLabel(label: 'Provinsi', subLabel: '* Wajib di isi'),
              _dropdownAddress(
                tag: 'province',
                select: controller.selectProvince,
                data: controller.addressProvince,
              ),
              _textLabel(label: 'Kabupaten', subLabel: '* Wajib di isi'),
              _dropdownAddress(
                tag: 'regency',
                select: controller.selectRegency,
                data: controller.addressRegency,
              ),
              _textLabel(label: 'Kecamatan', subLabel: '* Wajib di isi'),
              _dropdownAddress(
                tag: 'district',
                select: controller.selectDistrict,
                data: controller.addressDistrict,
              ),
              _textLabel(label: 'Kelurahan', subLabel: '* Wajib di isi'),
              _dropdownAddress(
                tag: 'village',
                select: controller.selectVillage,
                data: controller.addressVillage,
              ),
              _textLabel(label: 'Alamat Lengkapi', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.alamatTextEditingController,
                hintText:
                    'Isi alamat Lengkap\nJl Seturan, RT 02 RW05 Candi asih, Sleman...',
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (val) => controller.textInputValidatorController
                    .validatorNotNull(val),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                    onPressed: () => controller.onNext(),
                    child: Text(
                        (controller.authController.userModel.userStatus == '5')
                            ? 'Simpan'
                            : 'Cari Koor TPS')),
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonHideUnderline _dropdownReligion(
      {Rxn<LevelModel>? select, required RxList<LevelModel> data}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField<LevelModel>(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem<LevelModel>(
                value: val,
                child: Text(val.name),
              ),
            )
            .toList(),
        onChanged: (LevelModel? val) => controller.selectReligion.value = val,
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownJob(
      {Rxn<LevelModel>? select, required RxList<LevelModel> data}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField<LevelModel>(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem<LevelModel>(
                value: val,
                child: Text(val.name),
              ),
            )
            .toList(),
        onChanged: (LevelModel? val) => controller.selectJob.value = val,
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownAddress(
      {Rxn<AddressModel>? select,
      required RxList<AddressModel> data,
      required String tag}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(val.name),
              ),
            )
            .toList(),
        onChanged: (AddressModel? val) =>
            controller.onChangedDropdownAddress(val, tag: tag),
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownStatusPerkawinan(
      {required List<String> data}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField(
        borderRadius: borderRadius,
        items: data
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(val),
              ),
            )
            .toList(),
        onChanged: (String? val) =>
            controller.selectStatusPerkawinan.value = val.toString(),
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownGender(
      {RxString? select, required List<String> data}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField(
        borderRadius: borderRadius,
        // value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(val),
              ),
            )
            .toList(),
        onChanged: (String? val) =>
            controller.selectGender.value = val.toString(),
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
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
                : null,
          ),
          ListTile(
            leading: const Icon(Ionicons.image_outline),
            title: const Text('Galeri'),
            onTap: () async => (isPhoto)
                ? controller.getPhoto(source: ImageSource.gallery)
                : null,
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
