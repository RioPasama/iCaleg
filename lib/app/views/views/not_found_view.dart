import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

class NotFoundView extends GetView {
  const NotFoundView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(Assets.lottie.emptyStatePage),
        const Text('Tidak ada Data yang di temukan')
      ],
    );
  }
}
