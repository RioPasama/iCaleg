import 'package:flutter/material.dart';
import 'package:get/get.dart';

appBarDefault({required String title, bool leadign = false}) {
  return PreferredSize(
    preferredSize: Size(Get.width, AppBar().preferredSize.height + 60),
    child: const SizedBox(),
  );
}
