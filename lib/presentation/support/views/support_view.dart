import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/app/views/views/not_found_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/extensions/string_extension.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support/controllers/support.controller.dart';
import 'package:ionicons/ionicons.dart';

TabBarView bodyTabBarView() {
  return TabBarView(children: [
    dukungan(),
    relawan(),
    const SizedBox(),
    const SizedBox(),
  ]);
}

Obx dukungan() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Column(
      children: [
        _filtterBar(),
        Visibility(
            visible: controller.isLoadVoterDukungan.value,
            child: const Spacer()),
        (controller.isLoadVoterDukungan.value)
            ? loadingDefault()
            : (controller.voterDukunganModel.isEmpty)
                ? const NotFoundView()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.voterDukunganModel.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: colorGray),
                        ),
                        title: Text(controller.voterDukunganModel[index].name),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                        subtitle: Text(
                          'Waktu survey ${controller.voterDukunganModel[index].survey.toString().split(':').first}:${controller.voterDukunganModel[index].survey.toString().split(':')[1]}',
                          style: const TextStyle(
                              fontSize: 13, fontStyle: FontStyle.italic),
                        ),
                        isThreeLine: true,
                      );
                    },
                  ),
        Visibility(
            visible: controller.isLoadVoterDukungan.value,
            child: const Spacer(flex: 2)),
      ],
    ),
  );
}

Obx relawan() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Column(
      children: [
        _filtterBar(),
        Visibility(
            visible: !controller.isLoadVoterDukungan.value,
            child: const Spacer()),
        const Text('Prosess pembuatan'),
        const Visibility(visible: true, child: Spacer(flex: 2)),
      ],
    ),
  );
}

Container _filtterBar() {
  return Container(
    padding: const EdgeInsets.only(top: 28, bottom: 10),
    color: colorPrimary.withOpacity(0.8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: Get.width - 100,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: borderRadius),
                child: textFromFiled(hintText: 'Masukan Nama Pendukung')),
            ElevatedButton(
                onPressed: () {}, child: const Icon(Ionicons.options_outline))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: marginHorizontal),
          child: Text(
            'Menampilkan 10 dari 4.231 data',
            style: TextStyle(color: colorGray),
          ),
        )
      ],
    ),
  );
}
