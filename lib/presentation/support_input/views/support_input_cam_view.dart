import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support_input/controllers/support_input.controller.dart';

class SupportInputCamView extends GetView {
  SupportInputCamView({Key? key}) : super(key: key);

  @override
  final SupportInputController controller = Get.put(SupportInputController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Foto KTP',
              style: TextStyle(
                  color: colorTextPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            InkWell(
                // onTap: () => Get.bottomSheet(_bottomSheetPhoto(isPhoto: false)),
                onTap: controller.scanKtp,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                  child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Obx(() => Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: colorGray,
                                borderRadius: borderRadius,
                                image: (controller.pathIdenti?.value != '')
                                    ? DecorationImage(
                                        image: FileImage(
                                            File(controller.pathIdenti!.value)),
                                        fit: BoxFit.cover,
                                      )
                                    : null),
                            child: SvgPicture.asset(
                                Assets.icons.buttonPhotoIndeti),
                          ))),
                )),
            const Spacer(flex: 3)
          ]),
    );
  }

  // Container _bottomSheetPhoto({required bool isPhoto}) {
  //   return Container(
  //     height: 140,
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: Column(
  //       children: [
  //         ListTile(
  //           leading: const Icon(Ionicons.camera_outline),
  //           title: const Text('Kamera'),
  //           onTap: () async => (isPhoto)
  //               ? controller.getPhoto(source: ImageSource.camera)
  //               : controller.getIdenti(source: ImageSource.camera),
  //         ),
  //         ListTile(
  //           leading: const Icon(Ionicons.image_outline),
  //           title: const Text('Galeri'),
  //           onTap: () async => (isPhoto)
  //               ? controller.getPhoto(source: ImageSource.gallery)
  //               : controller.getIdenti(source: ImageSource.gallery),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
