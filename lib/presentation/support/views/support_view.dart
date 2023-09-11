import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/data/models/data_koordinator_model.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/app/views/views/not_found_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support/controllers/support.controller.dart';
import 'package:ionicons/ionicons.dart';

TabBarView bodyTabBarCalegView() {
  return TabBarView(children: [
    dukungan(),
    // relawan(),
    koorKoortes(),
    koorKoordus(),
    koorKoordes(),
    koorKorcam(),
  ]);
}

TabBarView bodyTabBarKorlapKecamatanView() {
  return TabBarView(children: [
    dukungan(),
    // relawan(),
    koorKoortes(),
    koorKoordus(),
    koorKoordes(),
    // koorKorcam(),
  ]);
}

TabBarView bodyTabBarKorlapKelurahanView() {
  return TabBarView(children: [
    dukungan(),
    // relawan(),
    koorKoortes(),
    koorKoordus(),
  ]);
}

TabBarView bodyTabBarKorlapDusunView() {
  return TabBarView(children: [
    dukungan(),
    koorKoortes(),
  ]);
}

TabBarView bodyTabBarKorlapTPSView() {
  return TabBarView(children: [
    dukungan(),
  ]);
}

Obx dukungan() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Stack(
      children: [
        Column(
          children: [
            _filtterBar(tag: '0'),
            Visibility(
                visible: controller.isLoadVoterDukungan.value,
                child: const Spacer()),
            Expanded(
              child: (controller.isLoadVoterDukungan.value)
                  ? loadingDefault()
                  : (controller.voterDukunganModel.isEmpty)
                      ? const NotFoundView()
                      : RefreshIndicator(
                          onRefresh: () => controller.getDukungan(),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.voterDukunganModel.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () => Get.toNamed(Routes.SUPPORT_DETAIL,
                                    arguments: {
                                      'isDukungan': true,
                                      'id': controller
                                          .voterDukunganModel[index].id
                                    }),
                                leading: ImageNetworkView(
                                  url: controller
                                      .voterDukunganModel[index].photo,
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: colorGray),
                                ),
                                title: Text(
                                    controller.voterDukunganModel[index].name),
                                titleTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                                subtitle: Text(
                                  'Waktu survey ${controller.voterDukunganModel[index].survey.toString().split(':').first}:${controller.voterDukunganModel[index].survey.toString().split(':')[1]}',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic),
                                ),
                                isThreeLine: true,
                              );
                            },
                          ),
                        ),
            ),
            Visibility(
                visible: controller.isLoadVoterDukungan.value,
                child: const Spacer(flex: 2)),
          ],
        ),
        Visibility(
          visible: controller.authController.userModel.userStatus != '1',
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78, right: 10),
              child: ElevatedButton(
                  onPressed: () => Get.bottomSheet(_bottomSheet()),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                  ),
                  child: const Icon(Ionicons.add)),
            ),
          ),
        ),
      ],
    ),
  );
}

Container _bottomSheet() {
  return Container(
    height: 140,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Column(
      children: [
        ListTile(
            leading: const Icon(Ionicons.scan),
            title: const Text('Input Scan KTP'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SUPPORT_INPUT, arguments: true);
            }),
        ListTile(
            leading: const Icon(Ionicons.document),
            title: const Text('Input Manual'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SUPPORT_INPUT, arguments: false);
            }),
      ],
    ),
  );
}

Obx koorKorcam() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Stack(
      children: [
        Column(
          children: [
            _filtterBar(tag: '2'),
            Visibility(
                visible: controller.isLoadVoterKorcam.value,
                child: const Spacer()),
            Expanded(
              child: (controller.isLoadVoterKorcam.value)
                  ? loadingDefault()
                  : (controller.dataKoordinatorKorcamModel.isEmpty)
                      ? const NotFoundView()
                      : RefreshIndicator(
                          onRefresh: () => controller.onTapSearch(tag: '2'),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.dataKoordinatorKorcamModel.length,
                            itemBuilder: (context, index) {
                              return _listTitle(
                                  controller.dataKoordinatorKorcamModel[index]);
                            },
                          ),
                        ),
            ),
            Visibility(
                visible: controller.isLoadVoterKorcam.value,
                child: const Spacer(flex: 2)),
          ],
        ),
        Visibility(
          visible: controller.authController.userModel.userStatus != '1',
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78, right: 10),
              child: ElevatedButton(
                  onPressed: () =>
                      Get.toNamed(Routes.REGISTRY_KOOR, arguments: 2),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                  ),
                  child: const Icon(Ionicons.add)),
            ),
          ),
        ),
      ],
    ),
  );
}

Obx koorKoordes() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Stack(
      children: [
        Column(
          children: [
            _filtterBar(tag: '3'),
            Visibility(
                visible: controller.isLoadVoterKordes.value,
                child: const Spacer()),
            Expanded(
              child: (controller.isLoadVoterKordes.value)
                  ? loadingDefault()
                  : (controller.dataKoordinatorKordesModel.isEmpty)
                      ? const NotFoundView()
                      : RefreshIndicator(
                          onRefresh: () => controller.onTapSearch(tag: '3'),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.dataKoordinatorKordesModel.length,
                            itemBuilder: (context, index) {
                              return _listTitle(
                                  controller.dataKoordinatorKordesModel[index]);
                            },
                          ),
                        ),
            ),
            Visibility(
                visible: controller.isLoadVoterKordes.value,
                child: const Spacer(flex: 2)),
          ],
        ),
        Visibility(
          visible: controller.authController.userModel.userStatus != '1',
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78, right: 10),
              child: ElevatedButton(
                  onPressed: () =>
                      Get.toNamed(Routes.REGISTRY_KOOR, arguments: 3),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                  ),
                  child: const Icon(Ionicons.add)),
            ),
          ),
        ),
      ],
    ),
  );
}

Obx koorKoordus() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Stack(
      children: [
        Column(
          children: [
            _filtterBar(tag: '4'),
            Visibility(
                visible: controller.isLoadVoterKordus.value,
                child: const Spacer()),
            Expanded(
              child: (controller.isLoadVoterKordus.value)
                  ? loadingDefault()
                  : (controller.dataKoordinatorKordusModel.isEmpty)
                      ? const NotFoundView()
                      : RefreshIndicator(
                          onRefresh: () => controller.onTapSearch(tag: '4'),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.dataKoordinatorKordusModel.length,
                            itemBuilder: (context, index) {
                              return _listTitle(
                                  controller.dataKoordinatorKordusModel[index]);
                            },
                          ),
                        ),
            ),
            Visibility(
                visible: controller.isLoadVoterKordus.value,
                child: const Spacer(flex: 2)),
          ],
        ),
        Visibility(
          visible: controller.authController.userModel.userStatus != '1',
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78, right: 10),
              child: ElevatedButton(
                  onPressed: () =>
                      Get.toNamed(Routes.REGISTRY_KOOR, arguments: 4),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                  ),
                  child: const Icon(Ionicons.add)),
            ),
          ),
        ),
      ],
    ),
  );
}

Obx koorKoortes() {
  final SupportController controller = Get.put(SupportController());
  return Obx(
    () => Stack(
      children: [
        Column(
          children: [
            _filtterBar(tag: '5'),
            Visibility(
                visible: controller.isLoadVoterKortep.value,
                child: const Spacer()),
            Expanded(
              child: (controller.isLoadVoterKortep.value)
                  ? loadingDefault()
                  : (controller.dataKoordinatorKortepModel.isEmpty)
                      ? const NotFoundView()
                      : RefreshIndicator(
                          onRefresh: () => controller.onTapSearch(tag: '5'),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.dataKoordinatorKortepModel.length,
                            itemBuilder: (context, index) {
                              return _listTitle(
                                  controller.dataKoordinatorKortepModel[index]);
                            },
                          ),
                        ),
            ),
            Visibility(
                visible: controller.isLoadVoterKortep.value,
                child: const Spacer(flex: 2)),
          ],
        ),
        Visibility(
          visible: controller.authController.userModel.userStatus != '1',
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78, right: 10),
              child: ElevatedButton(
                  onPressed: () =>
                      Get.toNamed(Routes.REGISTRY_KOOR, arguments: 5),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                  ),
                  child: const Icon(Ionicons.add)),
            ),
          ),
        ),
      ],
    ),
  );
}

ListTile _listTitle(DataKoordinatorModel data) {
  return ListTile(
    onTap: () => Get.toNamed(Routes.SUPPORT_DETAIL,
        arguments: {'isDukungan': false, 'id': data.id}),
    leading: ImageNetworkView(
      url: data.image,
      height: 80,
      width: 80,
      decoration: BoxDecoration(shape: BoxShape.circle, color: colorGray),
    ),
    title: Text(data.name),
    titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Dukungan : ${data.jumlahPendukung}',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        Visibility(
          visible: data.kortep != null,
          child: Text(
            'Koor TPS : ${data.kortep}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: data.kordus != null,
          child: Text(
            'Koor Dusun : ${data.kordus}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: data.kordes != null,
          child: Text(
            'Koor Desa : ${data.kordes}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: data.kordes != null,
          child: Text(
            'Koor Kecamatan : ${data.korcam}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          'Koord. ${data.namaAtasan}',
          style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
        ),
      ],
    ),
    isThreeLine: true,
  );
}

// Obx relawan() {
//   final SupportController controller = Get.put(SupportController());
//   return Obx(
//     () => Column(
//       children: [
//         _filtterBar(),
//         Visibility(
//             visible: !controller.isLoadVoterDukungan.value,
//             child: const Spacer()),
//         const Text('Prosess pembuatan'),
//         const Visibility(visible: true, child: Spacer(flex: 2)),
//       ],
//     ),
//   );
// }

Container _filtterBar({required String tag}) {
  final SupportController controller = Get.put(SupportController());
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
                child: textFromFiled(
                    controller: controller.search,
                    hintText: 'Masukan Nama Pendukung')),
            ElevatedButton(
                onPressed: () => controller.onTapSearch(tag: tag),
                child: const Icon(Ionicons.search))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: marginHorizontal),
          // child: Text(
          //   'Menampilkan 10 dari 4.231 data',
          //   style: TextStyle(color: colorGray),
          // ),
        )
      ],
    ),
  );
}
