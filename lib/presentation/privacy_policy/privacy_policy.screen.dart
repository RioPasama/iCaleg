import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

import 'controllers/privacy_policy.controller.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'KEBIJAKAN PRIVASI & KETENTUAN LAYANAN'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _expansionTile(
            label: 'Kebijakan Privasi',
            data:
                '"Data Pribadi" berarti data, baik benar maupun tidak, tentang individu yang dapat diidentifikasi dari data tersebut, atau dari data dan informasi lainnya yang dapat atau kemungkinan dapat diakses oleh suatu organisasi. Contoh umum data pribadi dapat mencakup nama, Nomor Kependudukan, Data yang dapat mengidentifikasi Identitas seseorang, dan/atau yang berdasarkan peraturan perundang- undang masuk dalam kategori data pribadi. Dengan menggunakan Layanan, mengunjungi Platform penyedia jasa, atau',
          ),
          _expansionTile(
            label: 'Ketentuan Layanan',
            data:
                '"Ketentuan layanan" berarti data, baik benar maupun tidak, tentang individu yang dapat diidentifikasi dari data tersebut, atau dari data dan informasi lainnya yang dapat atau kemungkinan dapat diakses oleh suatu organisasi. Contoh umum data pribadi dapat mencakup nama, Nomor Kependudukan, Data yang dapat mengidentifikasi Identitas seseorang, dan/atau yang berdasarkan peraturan perundang- undang masuk dalam kategori data pribadi. Dengan menggunakan Layanan, mengunjungi Platform penyedia jasa, atau',
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),
        child: ElevatedButton(
          onPressed: () => Get.toNamed(Routes.REGISTRY),
          child: const Text('Saya Mengerti dan Setuju'),
        ),
      ),
    );
  }

  Card _expansionTile({required String label, required String data}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: colorPrimary), borderRadius: borderRadius),
      child: ExpansionTile(
        childrenPadding:
            EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 10),
        title: Text(label),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 28),
          Text(
            'Pendahuluan',
            style: TextStyle(
                fontSize: 18,
                color: colorTextPrimary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 28),
          Text(data),
        ],
      ),
    );
  }
}
