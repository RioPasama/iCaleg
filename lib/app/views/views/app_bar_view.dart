import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

appBarDefault({required String title, bool leadign = false}) {
  return PreferredSize(
    preferredSize: Size(Get.width, AppBar().preferredSize.height),
    child: Stack(
      children: [
        Container(
          color: colorPrimary,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.fromLTRB(18, 6, 8, 6),
                      decoration: BoxDecoration(
                          color: colorBackgroundBack,
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(50))),
                      child: SvgPicture.asset(Assets.icons.backBotton)),
                ),
                SizedBox(
                  width: Get.width - 66,
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
