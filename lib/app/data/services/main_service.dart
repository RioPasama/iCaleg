import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icaleg/app/views/views/loading_view.dart';

class MainService {
  String urlAPIMain = 'https://icaleg.windypermadi.com/';
  late String urlRedirect = '${urlAPIMain}icaleg-restapi/api/';

  Future<dynamic> postAPI(
      {required String url, Map? body, http.Client? client}) async {
    client ??= http.Client();
    String apiHttp = urlRedirect + url;

    Get.dialog(loadingDefault(), barrierDismissible: false);

    final response = await http.post(Uri.parse(apiHttp), body: body);

    log('Url:$apiHttp\nBody\n$body\n${response.body}');

    final result = jsonDecode(response.body);
    Get.back();

    return result;
  }

  Future<dynamic> getAPI(
      {required String url,
      Map<String, dynamic>? body,
      http.Client? client}) async {
    client ??= http.Client();
    String queryString = Uri(queryParameters: body).query;
    String apiHttp = '$urlRedirect$url?$queryString';

    final response = await http.get(Uri.parse(apiHttp));

    log('Url:$apiHttp\nBody\n$body\n${response.body}');

    final result = jsonDecode(response.body);

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

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiHttp));

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

      log('Url: ${request.url}\nBody\n${request.fields}\n${request.files[0]} ${request.files[1]}\n${response.body}');

      final result = jsonDecode(response.body);

      if (!(result['code'] == 200)) {
        throw '';
      }

      Get.back();
      return result;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }
}
