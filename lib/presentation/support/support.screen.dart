import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/presentation/support/views/support_view.dart';

import 'controllers/support.controller.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SupportController());
    return (controller.authController.userModel.userStatus == '1')
        ? DefaultTabController(
            length: 6,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                elevation: 0,
                bottom: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'DUKUNGAN'),
                    Tab(text: 'SAKSI'),
                    Tab(text: 'RELAWAM TPS'),
                    Tab(text: 'KOORDINATOR\nDUSUN'),
                    Tab(text: 'KOORDINATOR\nDESA/KELURAHAN'),
                    Tab(text: 'KOORDINATOR\nKECAMATAN'),
                  ],
                ),
              ),
              body: bodyTabBarCalegView(),
            ),
          )
        : (controller.authController.userModel.userStatus == '2')
            ? DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 0,
                    elevation: 0,
                    bottom: const TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'DUKUNGAN'),
                        Tab(text: 'RELAWAM TPS'),
                        Tab(text: 'KOORDINATOR\nDUSUN'),
                        Tab(text: 'KOORDINATOR\nDESA/KELURAHAN'),
                      ],
                    ),
                  ),
                  body: bodyTabBarKorlapKecamatanView(),
                ),
              )
            : (controller.authController.userModel.userStatus == '3')
                ? DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 0,
                        elevation: 0,
                        bottom: const TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(text: 'DUKUNGAN'),
                            Tab(text: 'RELAWAM TPS'),
                            Tab(text: 'KOORDINATOR\nDUSUN'),
                          ],
                        ),
                      ),
                      body: bodyTabBarKorlapKelurahanView(),
                    ),
                  )
                : (controller.authController.userModel.userStatus == '4')
                    ? DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: AppBar(
                            toolbarHeight: 0,
                            elevation: 0,
                            bottom: const TabBar(
                              isScrollable: true,
                              tabs: [
                                Tab(text: 'DUKUNGAN'),
                                Tab(text: 'RELAWAM TPS'),
                              ],
                            ),
                          ),
                          body: bodyTabBarKorlapDusunView(),
                        ),
                      )
                    : (controller.authController.userModel.userStatus == '5')
                        ? DefaultTabController(
                            length: 1,
                            child: Scaffold(
                              appBar: AppBar(
                                toolbarHeight: 0,
                                elevation: 0,
                                bottom: const TabBar(
                                  isScrollable: true,
                                  tabs: [
                                    Tab(text: 'DUKUNGAN'),
                                  ],
                                ),
                              ),
                              body: bodyTabBarKorlapTPSView(),
                            ),
                          )
                        : (controller.authController.userModel.userStatus ==
                                '6')
                            ? const SizedBox()
                            : const SizedBox();
    // ([
    //   '2',
    //   '3',
    //   '4',
    //   '5',
    // ].any((val) => val == controller.authController.userModel.userStatus))
    //     ? Scaffold(
    //         appBar: AppBar(toolbarHeight: 0),
    //         floatingActionButton: Padding(
    //           padding: const EdgeInsets.only(bottom: 68),
    //           child: ElevatedButton(
    //               onPressed: () => Get.toNamed(Routes.SUPPORT_INPUT),
    //               style: ElevatedButton.styleFrom(
    //                 shape: const CircleBorder(),
    //                 padding: const EdgeInsets.all(18),
    //               ),
    //               child: const Icon(Ionicons.add)),
    //         ),
    //         body: dukungan(),
    //       )
    //     : DefaultTabController(
    //         length: 6,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             toolbarHeight: 0,
    //             bottom: const TabBar(
    //               isScrollable: true,
    //               tabs: [
    //                 Tab(text: 'DUKUNGAN'),
    //                 Tab(text: 'SAKSI'),
    //                 Tab(text: 'RELAWAM TPS'),
    //                 Tab(text: 'KOORDINATOR\nDUSUN'),
    //                 Tab(text: 'KOORDINATOR\nDESA/KELURAHAN'),
    //                 Tab(text: 'KOORDINATOR\nKECAMATAN'),
    //               ],
    //             ),
    //           ),
    //           body: bodyTabBarView(),
    //         ),
    //       );
  }
}
