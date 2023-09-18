import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _appBar(),
            Padding(
              padding: const EdgeInsets.only(top: 138),
              child: Obx(
                () => (controller.isLoading.value)
                    ? loadingDefault()
                    : Column(
                        children: [
                          _infoUser(),
                          _statistikPrimary(),
                          _statistikSecondary(),
                          _webView()
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _webView() {
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));
    return Container(
      height: 680,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 100),
      child: InAppWebView(
        key: controller.webViewKey,
        initialOptions: options,
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://cekdptonline.kpu.go.id')),
        // shouldOverrideUrlLoading:
        //     (controller, navigationAction) async {
        // final uri = navigationAction.request.url!;

        // log('url ${navigationAction.request.url}');
        // // if ((uri.toString()).startsWith(
        // //     'https://dev.andipublisher.com/midtrans/transaksi/finish?')) {
        // //   Get.offAllNamed(Routes.MAIN);
        // //   return null;
        // // } else if ((uri.toString())
        // //     .startsWith('https://app.midtrans.com')) {
        // //   return null;
        // // } else if ((uri.toString())
        // //     .startsWith('https://app.sandbox.midtrans.com')) {
        // //   return null;
        // // }
        // log('test1' + uri.toString());
        // if ((uri.toString()).contains('finish')) {
        //   Get.offAllNamed(Routes.MAIN);
        //   return null;
        // } else if ((uri.toString())
        //     .startsWith('https://app.midtrans.com')) {
        //   return null;
        // } else if ((uri.toString())
        //     .startsWith('https://app.sandbox.midtrans.com')) {
        //   return null;
        // }
        // launchUrl(Uri.parse(uri.toString()),
        //     mode: LaunchMode.externalApplication);
        // return NavigationActionPolicy.CANCEL;
        // }
      ),
    );
  }

  SizedBox _statistikSecondary() {
    return SizedBox(
      height: 68,
      width: Get.width,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            _cardStatistikSecondary(
              lable: 'Alokasi Kursi',
              value: controller.homeModel.value!.statistik.alokasiKursi,
            ),
            _cardStatistikSecondary(
              lable: 'TPS',
              value: controller.homeModel.value!.statistik.tps,
            ),
            _cardStatistikSecondary(
              lable: 'DPT Dapil',
              value: controller.homeModel.value!.statistik.dptDapil,
            ),
          ],
        ),
      ),
    );
  }

  Container _cardStatistikSecondary(
      {required String lable, required int value}) {
    return Container(
      height: 68,
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 68,
              width: 106,
              decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: borderRadius,
                  boxShadow: [boxShadow]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 64,
              width: 110,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                  boxShadow: [boxShadow]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lable,
                    style: TextStyle(
                        color: colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      NumberFormat.decimalPattern('id').format(value),
                      style: TextStyle(
                          color: colorTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _statistikPrimary() {
    return Container(
      height: 130,
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
        children: [
          _cardStatistikPrimary(
            lable: 'Total Dukungan',
            value: controller.homeModel.value!.statistik.totalDukungan,
            icon: Ionicons.people_outline,
            colorData: const Color(0xFF02754C),
            colorBackground: const Color(0xFFD3F6EA),
          ),
          _cardStatistikPrimary(
            lable: 'Jumlah Relawan',
            value: controller.homeModel.value!.statistik.totalRelawan,
            icon: Ionicons.person_add_outline,
            colorData: const Color(0xFFC39D00),
            colorBackground: const Color(0xFFFEF6D5),
          ),
          _cardStatistikPrimary(
            lable: 'Target Dukungan',
            value: controller.homeModel.value!.statistik.targetDukungan,
            icon: Ionicons.pulse_outline,
            colorData: const Color(0xFF3598DB),
            colorBackground: const Color(0xFFDCEFFC),
          ),
        ],
      ),
    );
  }

  Container _cardStatistikPrimary({
    required String lable,
    required int value,
    required IconData icon,
    required Color colorData,
    required Color colorBackground,
  }) {
    return Container(
      width: 166,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 14),
            child: Text(
              NumberFormat.decimalPattern('id').format(value),
              style: TextStyle(
                  color: colorData, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              lable,
              style: TextStyle(color: colorData, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Icon(
              icon,
              size: 34,
              color: colorData,
            ),
          )
        ],
      ),
    );
  }

  Container _infoUser() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border.all(color: colorPrimary)),
      child: Row(
        children: [
          ImageNetworkView(
            url: controller.homeModel.value?.images ?? '',
            height: Get.width / 3.8,
            width: Get.width / 3.8,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: colorGray,
                shape: BoxShape.circle,
                boxShadow: [boxShadow]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  controller.homeModel.value!.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  '${controller.homeModel.value!.level} ${controller.homeModel.value!.daerahPemilihan}',
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width / 2,
                child: const Text('PARTAI POLITIK'),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  controller.homeModel.value!.partai,
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width / 2,
                child: const Text('DAERAH PEMILIHAN'),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  controller.homeModel.value!.daerahPemilihan,
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _appBar() {
    return Container(
      padding: const EdgeInsets.only(top: 48, bottom: 100),
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [colorPrimary, colorPrimaryGradient]),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(60)),
          boxShadow: [boxShadow]),
      child: Row(
        children: [
          Image.asset(
            Assets.images.logoIcaleg.path,
            width: 80,
          ),
          SvgPicture.asset(
            Assets.images.logoText,
            width: 100,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          )
        ],
      ),
    );
  }
}
