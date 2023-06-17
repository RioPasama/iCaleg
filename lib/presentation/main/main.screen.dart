import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/main.controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MainScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
