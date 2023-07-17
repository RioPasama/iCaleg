import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';

class UtilsController extends GetxController {
  Future<void> checkConnection() async {
    final Connectivity connectivity = Connectivity();
    late ConnectivityResult result;
    late bool isConnectivity;

    Future<ConnectivityResult> getConnection() async {
      return await connectivity.checkConnectivity();
    }

    Future<bool> dialog() async {
      if (result == ConnectivityResult.none) {
        log('connectivity none');
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
