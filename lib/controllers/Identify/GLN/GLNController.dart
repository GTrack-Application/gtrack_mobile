// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:gtrack_mobile_app/constants/app_preferences.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/Identify/GLN/GLNProductsModel.dart';
import 'package:http/http.dart' as http;

class GLNController {
  static Future<List<GLNProductsModel>> getData() async {
    String? userId = await AppPreferences.getUserId();
    String? token = await AppPreferences.getToken();
    String url = "${AppUrls.baseUrlWith3093}/api/gln?user_id=$userId";

    print(url);

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Host": AppUrls.host,
      "Authorization": "Bearer $token",
    };

    var response = await http.get(uri, headers: headers);

    print(json.decode(response.body));

    var data = json.decode(response.body) as List;

    if (response.statusCode == 200) {
      List<GLNProductsModel> products = data
          .map((e) => GLNProductsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return products;
    } else {
      return [];
    }
  }
}
