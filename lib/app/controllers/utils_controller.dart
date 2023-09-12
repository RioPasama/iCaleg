import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';

class UtilsController extends GetxController {
  Color getRandomColor() {
    final Random random = Random();
    final int r = random.nextInt(256); // Komponen merah (0-255)
    final int g = random.nextInt(256); // Komponen hijau (0-255)
    final int b = random.nextInt(256); // Komponen biru (0-255)
    return Color.fromARGB(
        255, r, g, b); // Warna acak dengan alpha 255 (sepenuhnya terlihat)
  }

  Future<void> checkConnection() async {
    final Connectivity connectivity = Connectivity();
    late ConnectivityResult result;
    late bool isConnectivity;

    Future<ConnectivityResult> getConnection() async {
      return await connectivity.checkConnectivity();
    }

    Future<bool> dialog() async {
      if (result == ConnectivityResult.none) {
        // log('connectivity none');
        await Get.dialog(
          dialogView(
            title: 'Koneksi',
            content: 'Pastikan koneksi anda terhubung',
            onTapOke: () {
              Get.back();
            },
          ),
        );
        return false;
      } else {
        return true;
      }
    }

    do {
      result = await getConnection();
      isConnectivity = await dialog();
    } while (!isConnectivity);
  }
}
