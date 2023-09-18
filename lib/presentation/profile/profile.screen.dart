import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/image_network_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/profile/views/profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controllers/profile.controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Stack(
          children: [
            (controller.authController.userModel.userStatus == '1')
                ? profileCaleg()
                : profileKoor(),
            _appBar(),
          ],
        ));
  }

  Align _appBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 130,
        child: Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [colorPrimary, colorPrimaryGradient]),
                boxShadow: [boxShadow],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () => controller.utilsController.openUrl(
                      url: 'https://icaleg.com/privacypolicy.html',
                      mode: LaunchMode.inAppWebView),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('Privacy Policy'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ImageNetworkView(
                url: controller.authController.userModel.image,
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: colorGray, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
