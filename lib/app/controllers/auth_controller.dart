import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icaleg/app/data/models/user_model.dart';

class AuthController extends GetxController {
  late UserModel userModel;

  RxBool isLogin = false.obs;
  String? token;

  void saveToken({required String token}) {
    GetStorage().write('token', token);
  }

  void saveDataUser({required UserModel userModel}) {
    Map<String, dynamic> userMap = userModel.toJson();
    String json = jsonEncode(userMap);
    GetStorage().write('user', json);
  }

  void getDataToken() {
    token = GetStorage().read('token');
    isLogin.value = token != null;

    log('token $token');
  }

  void getDataUser() {
    String? user = GetStorage().read('user');
    if (user != null) {
      Map<String, dynamic> userMap = jsonDecode(user);
      userModel = UserModel.fromJson(userMap);
      log(user.toString());
      // isLogin.value = userModel.nik.isNotEmpty;
    }

    log('isLogin $isLogin');
  }
}
