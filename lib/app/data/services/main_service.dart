import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';

class MainService {
  AuthController authController = Get.put(AuthController());

  String urlAPIMain = 'https://icaleg.windypermadi.com/';
  late String urlRedirect = '${urlAPIMain}icaleg-restapi/api/';

  Future<dynamic> postAPI(
      {required String url, Map? body, http.Client? client}) async {
    client ??= http.Client();
    String apiHttp = urlRedirect + url;

    Get.dialog(loadingDefault(), barrierDismissible: false);
    authController.getDataToken();

    final response = await http.post(
      Uri.parse(apiHttp),
      headers: (authController.isLogin.value)
          ? {'Authorization': 'Bearer ${authController.token}'}
          : null,
      body: body,
    );

    log('Url:$apiHttp\nBody\n$body\n${response.body}');

    final result = jsonDecode(response.body);
    Get.back();

    if (result['code'].toString()[0] != '2') {
      Get.dialog(
        dialogView(
          title: 'Terjadi Kesalahan',
          content: result['message'],
          onTapOke: () => Get.back(),
        ),
      );
    }

    return result;
  }

  Future<dynamic> getAPI(
      {required String url,
      Map<String, dynamic>? body,
      http.Client? client}) async {
    client ??= http.Client();
    String queryString = Uri(queryParameters: body).query;
    String apiHttp = '$urlRedirect$url?$queryString';
    authController.getDataToken();
    final response = await http.get(Uri.parse(apiHttp),
        headers: (authController.isLogin.value)
            ? {'Authorization': 'Bearer ${authController.token}'}
            : null);

    log('Url:$apiHttp\nBody\n$body\n${response.body}');

    final result = jsonDecode(response.body);

    if (result['code'].toString()[0] != '2') {
      Get.dialog(
        dialogView(
          title: 'Terjadi Kesalahan',
          content: result['message'],
          onTapOke: () => Get.back(),
        ),
      );
    }

    return result;
  }

  Future<dynamic> postMultipartRequestAPI(
      {required String url,
      Map<String, dynamic>? fields,
      required List<http.MultipartFile> files,
      http.Client? client}) async {
    String apiHttp = urlRedirect + url;
    client ??= http.Client();

    Get.dialog(loadingDefault(), barrierDismissible: false);
    authController.getDataToken();
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiHttp));

      if (authController.isLogin.value) {
        // Menambahkan header pada request
        request.headers['Authorization'] = 'Bearer ${authController.token}';
      }

      // Menambahkan fields ke dalam permintaan multipart
      fields?.forEach((key, value) {
        request.fields[key] = value.toString();
      });

// Menambahkan files ke dalam permintaan multipart
      for (http.MultipartFile file in files) {
        request.files.add(file);
      }

      // Mengirim permintaan multipart
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Url: ${request.url}\nBody\n${request.fields}\n${request.files[0].filename} ${request.files[1].filename}\n${response.body}');

      final result = jsonDecode(response.body);
      Get.back();
      if (result['code'].toString()[0] != '2') {
        Get.dialog(
          dialogView(
            title: 'Terjadi Kesalahan',
            content: result['message'],
            onTapOke: () => Get.back(),
          ),
        );
      }

      return result;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }
}
