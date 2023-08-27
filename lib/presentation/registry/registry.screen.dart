import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/data/models/address_model.dart';
import 'package:icaleg/app/data/models/dapil_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';
import 'package:icaleg/app/data/models/partai_model.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import 'controllers/registry.controller.dart';

class RegistryScreen extends GetView<RegistryController> {
  const RegistryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(RegistryController());

    return Scaffold(
      appBar: appBarDefault(title: 'FORMULIR REGISTRASI'),
      body: Form(
          key: controller.formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
            children: [
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
              _textLabel(label: 'Jenis Kelamin', subLabel: '* Wajib di isi'),
              _dropdownGender(
                  data: controller.gender, select: controller.selectGender),
              _textLabel(label: 'Agama', subLabel: '* Wajib di isi'),
              _dropdownReligion(
                  data: controller.religion, select: controller.selectReligion),
              _textLabel(label: 'Email', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.emailTextEditingController,
                hintText: 'Isi Email',
                keyboardType: TextInputType.emailAddress,
                validator: (val) => controller.textInputValidatorController
                    .validatorIdentifier(val),
              ),
              // _textLabel(label: 'Kata Sandi', subLabel: '* Wajib di isi'),
              // Obx(
              //   () => textFromFiled(
              //     controller: controller.kataSandiTextEditingController,
              //     hintText: 'Isi Kata Sandi',
              //     obscureText: controller.obscureKataSandi.value,
              //     suffixIcon: IconButton(
              //         onPressed: () => controller.obscureKataSandi.toggle(),
              //         icon: Icon((controller.obscureKataSandi.value)
              //             ? Ionicons.eye_off_outline
              //             : Ionicons.eye_outline)),
              //     validator: (val) => controller.textInputValidatorController
              //         .validatorNotNull(
              //             controller.kataSandiTextEditingController.text),
              //   ),
              // ),
              // _textLabel(
              //     label: 'Konfirmasi Kata Sandi', subLabel: '* Wajib di isi'),
              // Obx(
              //   () => textFromFiled(
              //     controller:
              //         controller.konformasiKataSandiTextEditingController,
              //     hintText: 'Isi Konfirmasi Kata Sandi',
              //     obscureText: controller.obscureKonfirmasiKataSandi.value,
              //     suffixIcon: IconButton(
              //         onPressed: () =>
              //             controller.obscureKonfirmasiKataSandi.toggle(),
              //         icon: Icon((controller.obscureKonfirmasiKataSandi.value)
              //             ? Ionicons.eye_off_outline
              //             : Ionicons.eye_outline)),
              //     validator: (val) => controller.textInputValidatorController
              //         .validatorConfirmationPassword(
              //             val: val,
              //             passwordTextEditingController:
              //                 controller.kataSandiTextEditingController.text),
              //   ),
              // ),
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
              _textLabel(label: 'Level Pemilihan', subLabel: '* Wajib di isi'),
              _dropdownLevel(
                select: controller.selectLevel,
                data: controller.levelModel,
              ),
              _textLabel(label: 'Role Pengguna', subLabel: '* Wajib di isi'),
              _dropdownRole(
                select: controller.selectRole,
                data: controller.roleModel,
              ),
              _textLabel(label: 'DAPIL', subLabel: '* Wajib di isi'),
              _dropdownDapil(
                select: controller.selectDapil,
                data: controller.dapilModel,
              ),
              _textLabel(label: 'Partai Politik', subLabel: '* Wajib di isi'),
              _dropdownPartai(
                select: controller.selectPartai,
                data: controller.partaiModel,
              ),
              Obx(
                () => Visibility(
                  visible: controller.selectRole.value?.id != '1',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textLabel(
                          label: 'Kode Referal', subLabel: '* Wajib di isi'),
                      textFromFiled(
                        controller: controller.referalCodeTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Isi Kode Referal',
                      ),
                    ],
                  ),
                ),
              ),
              _textLabel(label: 'Alamat Lengkapi', subLabel: '* Wajib di isi'),
              textFromFiled(
                controller: controller.addressTextEditingController,
                hintText:
                    'Isi alamat Lengkap\nJl Seturan, RT 02 RW05 Candi asih, Sleman...',
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (val) => controller.textInputValidatorController
                    .validatorNotNull(val),
              ),
              Row(
                // alignment: WrapAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buttonPhoto(
                    label: 'Foto Profile',
                    icon: Assets.icons.buttonPhotoPreson,
                    isPhoto: true,
                    path: controller.pathPhoto,
                    onTap: () =>
                        Get.bottomSheet(_bottomSheetPhoto(isPhoto: true)),
                  ),
                  _buttonPhoto(
                    label: 'Foto Kartu Tanda Penduduk (KTP)',
                    icon: Assets.icons.buttonPhotoIndeti,
                    isPhoto: false,
                    path: controller.pathIdenti,
                    onTap: () =>
                        Get.bottomSheet(_bottomSheetPhoto(isPhoto: false)),
                  )
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                    onPressed: () => controller.onTapRegistry(),
                    child: const Text('Daftar')),
              )
            ],
          )),
    );
  }

  DropdownButtonHideUnderline _dropdownReligion({
    required List<String> data,
    RxString? select,
  }) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(val),
              ),
            )
            .toList(),
        onChanged: (String? val) =>
            controller.selectReligion?.value = val.toString(),
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownGender({
    RxString? select,
    required List<String> data,
  }) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(val),
              ),
            )
            .toList(),
        onChanged: (String? val) =>
            controller.selectGender?.value = val.toString(),
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

  DropdownButtonHideUnderline _dropdownDapil(
      {Rxn<DapilModel>? select, required RxList<DapilModel> data}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField<DapilModel>(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem<DapilModel>(
                value: val,
                child: Text(val.name),
              ),
            )
            .toList(),
        onChanged: (DapilModel? val) => controller.selectDapil.value = val,
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownLevel(
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
        onChanged: (LevelModel? val) => controller.fetchDapil(levelModel: val),
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownRole(
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
        onChanged: (LevelModel? val) => controller.selectRole.value = val,
        isExpanded: true,
        validator: (val) =>
            controller.textInputValidatorController.validatorNotNull(val),
      ),
    ));
  }

  DropdownButtonHideUnderline _dropdownPartai(
      {Rxn<PartaiModel>? select, required RxList<PartaiModel> data}) {
    return DropdownButtonHideUnderline(
        child: Obx(
      () => DropdownButtonFormField<PartaiModel>(
        borderRadius: borderRadius,
        value: select?.value,
        items: data
            .map(
              (val) => DropdownMenuItem<PartaiModel>(
                value: val,
                child: Text(val.name),
                //  Row(
                //   children: [
                //     Container(
                //       height: 100,
                //       width: 24,
                //       color: colorGray,
                //       margin: const EdgeInsets.only(right: 10),
                //     ),
                //     Text(val.name),
                //   ],
                // ),
              ),
            )
            .toList(),
        onChanged: (PartaiModel? val) => controller.selectPartai.value = val,
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
