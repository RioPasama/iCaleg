import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:ionicons/ionicons.dart';

import 'controllers/support.controller.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SupportController());
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'DUKUNGAN'),
              Tab(text: 'RELAWAM TPS'),
              Tab(text: 'KOORDINATOR\nDESA/KELURAHAN'),
              Tab(text: 'KOORDINATOR\nKECAMATAN'),
            ],
          ),
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 68),
        //   child: ElevatedButton(
        //       onPressed: () {},
        //       style: ElevatedButton.styleFrom(
        //         shape: const CircleBorder(),
        //         padding: const EdgeInsets.all(18),
        //       ),
        //       child: const Icon(Ionicons.add)),
        // ),
        body: TabBarView(children: [
          Obx(
            () => Column(
              children: [
                _appBar(),
                Visibility(
                    visible: controller.isLoadVoterDukungan.value,
                    child: const Spacer()),
                (controller.isLoadVoterDukungan.value)
                    ? loadingDefault()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: colorGray),
                            ),
                            title: const Text('ssss'),
                            titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                            subtitle: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ssad'),
                                Text(
                                  'Waktu survey',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
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
          ),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ]),
      ),
    );
  }

  Container _appBar() {
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
}
