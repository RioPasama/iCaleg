import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UtilsController extends GetxController {
  Future<void> onTapClipboard({required String text}) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<void> openUrl({required String url, required LaunchMode mode}) async {
    if (!await launchUrlString(url, mode: mode)) {
      Get.dialog(dialogView(
        title: 'Error Url',
        content: 'Could not launch $url',
        onTapOke: () => Get.back(),
      ));
    }
  }

  String convertStringColorHex({required String hex}) {
    return hex.split('x').last;
  }

  bool isHexStringValid(String hex) {
    if (hex.length < 2 && hex.length > 8) {
      return false;
    }

    if (!hex.startsWith('#')) {
      return false;
    }

    for (int i = 1; i < hex.length; i++) {
      if (!RegExp(r'[0-9a-fA-F]').hasMatch(hex[i])) {
        return false;
      }
    }

    return true;
  }

  Color colorFromHex({required String hex}) {
    final buffer = StringBuffer();
    buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }

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
