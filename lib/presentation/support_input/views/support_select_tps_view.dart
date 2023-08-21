import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/support_input/controllers/support_input.controller.dart';

class SupportSelectTpsView extends GetView {
  SupportSelectTpsView({Key? key}) : super(key: key);

  @override
  final SupportInputController controller = Get.put(SupportInputController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 16),
      child: Column(
        children: [
          textFromFiled(
            controller: controller.tpsTextEditingController,
            keyboardType: TextInputType.datetime,
            hintText: 'Isi TPS',
            validator: (val) =>
                controller.textInputValidatorController.validatorNotNull(val),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () => controller.onTapGetKoorlapTPS(),
              child: const Text(' Cari Koor TPS '),
            ),
          ),
          Expanded(
              child: Obx(
            () => (!controller.isLoaded.value)
                ? (!controller.isEmty.value)
                    ? ListView.builder(
                        itemCount: controller.koorlapTps.length,
                        itemBuilder: (context, index) => Obx(
                              () => ListTile(
                                onTap: () => controller.selectKoorlapTps.value =
                                    controller.koorlapTps[index],
                                leading: Container(
                                  height: 80,
                                  width: 80,
                                  color: colorGray,
                                ),
                                title: Text(controller.koorlapTps[index].name),
                                selected: controller.selectKoorlapTps.value ==
                                    controller.koorlapTps[index],
                              ),
                            ))
                    : const Center(child: Text('Tidak ada Koorlap TPS'))
                : loadingDefault(),
          )),
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
                onPressed: () => controller.onTapRegistry(),
                child: const Text('Simpan')),
          )
        ],
      ),
    );
  }
}
