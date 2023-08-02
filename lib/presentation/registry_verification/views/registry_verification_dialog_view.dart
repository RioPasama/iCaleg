import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/registry_verification/controllers/registry_verification.controller.dart';

class RegistryVerificationDialogView extends GetView {
  RegistryVerificationDialogView({Key? key}) : super(key: key);

  @override
  final RegistryVerificationController controller =
      Get.put(RegistryVerificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
          boxShadow: [boxShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.icons.iconCorrect),
          Text(
            'REGISTRASI SUKSES',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorTextPrimary),
          ),
          Text(
            'Akun Anda berhasil diaktivasi',
            style: TextStyle(color: colorTextGray),
          ),
          loadingDefault(),
          Text(
            'Kamu akan diarahkan ke halaman login',
            style: TextStyle(color: colorTextGray),
          ),
        ],
      ),
    );
  }
}
