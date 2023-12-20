import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/home_model.dart';
import 'package:icaleg/app/data/services/home_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  AuthController authController = Get.put(AuthController());

  final GlobalKey webViewKey = GlobalKey();

  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    authController.getDataUser();
    super.onInit();
  }

  @override
  void onReady() {
    fetchHome();
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> fetchHome() async {
    homeModel.value = await HomeService.getHome();
    isLoading.value = false;
  }

  WebViewController controllerWeb = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://cekdptonline.kpu.go.id/'));
}
