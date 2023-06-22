import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.fromLTRB(40, 50, 40, 20),
            color: colorGray,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(27),
                boxShadow: [boxShadow]),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Selamat Datang!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 6),
              Text('Silahkan masuk terlebih dahulu'),
              Align(
                alignment: Alignment.bottomRight,
                child:
                    TextButton(onPressed: () {}, child: Text('Lupa Password')),
              ),
              SizedBox(
                  width: Get.width,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text('Masuk'))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width / 2 - (64),
                    child: Divider(thickness: 1),
                  ),
                  Text(
                    ' atau ',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: Get.width / 2 - (64),
                    child: Divider(thickness: 1),
                  ),
                ],
              ),
              SizedBox(
                  width: Get.width,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text('Daftar')))
            ]),
          )
        ],
      ),
    ));
  }
}
