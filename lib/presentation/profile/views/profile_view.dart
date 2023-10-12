import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/profile/controllers/profile.controller.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

Widget profileCaleg() {
  ProfileController controller = Get.put(ProfileController());
  return ListView(
    padding: const EdgeInsets.only(top: 140),
    children: [
      Column(children: [
        Text(
          controller.authController.userModel.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorTextPrimary,
          ),
        ),
        Text(
          controller.authController.userModel.ketStatus.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorTextPrimary,
          ),
        ),
      ]),
      _listviewTitle(
        title: 'Partai Politik',
        subTitle: controller.authController.userModel.partai,
      ),
      _listviewTitle(
        title: 'Daerah Pemilih',
        subTitle: controller.authController.userModel.labelDusun,
      ),
      _listviewTitle(
        title: 'Jenis Kelamin',
        subTitle: controller.authController.userModel.gender,
      ),
      _listviewTitle(
        title: 'Tempat Tanggal Lahir',
        subTitle:
            '${controller.authController.userModel.born} ${controller.authController.userModel.birthday.toString().split(' ').first}',
      ),
      _listviewTitle(
        title: 'Email',
        subTitle: controller.authController.userModel.email,
      ),
      _listviewTitle(
        title: 'No. Handphone',
        subTitle: controller.authController.userModel.phone,
      ),
      _listviewTitle(
        title: 'Kode Referral',
        subTitle: controller.authController.userModel.referalCode,
        activeClipboard: true,
      ),
      const Divider(thickness: 2),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 10),
        child: ElevatedButton(
            onPressed: () => controller.onTapEditProfile(),
            child: const Text('Edit Profil')),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 10),
        child: ElevatedButton(
            onPressed: () => controller.onTapLogout(),
            style: ElevatedButton.styleFrom(backgroundColor: colorRad),
            child: const Text('Keluar')),
      ),
      const SizedBox(height: 100),
    ],
  );
}

Widget profileSaksi() {
  return const SizedBox();
}

Widget profileKoor() {
  ProfileController controller = Get.put(ProfileController());
  return ListView(
    padding: const EdgeInsets.only(top: 140),
    children: [
      Column(
        children: [
          Text(
            controller.authController.userModel.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorTextPrimary,
            ),
          ),
          Text(
            controller.authController.userModel.ketStatus.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorTextPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            NumberFormat.decimalPattern('id')
                .format(controller.authController.userModel.total),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colorTextPrimary,
            ),
          ),
          const Text('Total Anggota')
        ],
      ),
      const SizedBox(height: 20),
      Container(
        padding:
            EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 8),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 2, color: colorGray))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tim Suskes',
              style: TextStyle(color: colorTextPrimary),
            ),
            Obx(
              () => Text(
                controller.homeModel.value?.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: colorTextPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
      _listviewTitle(
        title: 'Partai Politik',
        subTitle: controller.authController.userModel.partai,
      ),
      Obx(
        () => _listviewTitle(
          title: 'Daerah Pemilih',
          subTitle: controller.homeModel.value?.daerahPemilihan ?? '',
        ),
      ),
      _listviewTitle(
        title: 'NIK',
        subTitle: controller.authController.userModel.nik,
      ),
      _listviewTitle(
        title: 'Jenis Kelamin',
        subTitle: controller.authController.userModel.gender,
      ),
      _listviewTitle(
        title: 'Tempat Tanggal Lahir',
        subTitle:
            '${controller.authController.userModel.born} ${controller.authController.userModel.birthday.toString().split(' ').first}',
      ),
      _listviewTitle(
        title: 'Email',
        subTitle: controller.authController.userModel.email,
      ),
      _listviewTitle(
        title: 'No. Handphone',
        subTitle: controller.authController.userModel.phone,
      ),
      const Divider(thickness: 2),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 10),
        child: ElevatedButton(
            onPressed: () => controller.onTapEditProfile(),
            child: const Text('Edit Profil')),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 10),
        child: ElevatedButton(
            onPressed: () => controller.onTapLogout(),
            style: ElevatedButton.styleFrom(backgroundColor: colorRad),
            child: const Text('Keluar')),
      ),
      const SizedBox(height: 100),
    ],
  );
}

Container _listviewTitle(
    {required String title,
    required String subTitle,
    bool activeClipboard = false}) {
  ProfileController controller = Get.put(ProfileController());
  return Container(
    padding: EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 8),
    decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 2, color: colorGray))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: colorTextPrimary),
        ),
        Row(
          children: [
            Text(
              subTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: activeClipboard,
              child: IconButton(
                  onPressed: () =>
                      controller.utilsController.onTapClipboard(text: subTitle),
                  icon: const Icon(Ionicons.copy_outline)),
            )
          ],
        ),
      ],
    ),
  );
}
