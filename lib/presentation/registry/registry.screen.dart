import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

import 'controllers/registry.controller.dart';

class RegistryScreen extends GetView<RegistryController> {
  const RegistryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'FORMULIR REGISTRASI'),
      body: Form(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
        children: [
          _textLabel(label: 'Nama Lengkap', subLabel: '* Wajib di isi'),
          textFromFiled(hintText: 'Isi Nama Lengkap'),
          _textLabel(label: 'NIK', subLabel: '* Wajib di isi'),
          textFromFiled(hintText: 'Isi NIK'),
          _textLabel(label: 'Email', subLabel: '* Wajib di isi'),
          textFromFiled(hintText: 'Isi Email'),
          ElevatedButton(onPressed: () {}, child: const Text('Daftar'))
        ],
      )),
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
