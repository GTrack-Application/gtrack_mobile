// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/share/product_information/gtin_information_model.dart';
import 'package:http/http.dart' as http;

class GtinInformationController {
  static Future<GtinInformationModel> getGtinInformation(String gtin) async {
    final url = Uri.parse("${AppUrls.domain}/api/search/member/gtin");

    final body = jsonEncode({
      "gtin": gtin,
    });

    final headers = {
      "Content-Type": "application/json",
      "Host": AppUrls.host,
    };

    // print("body: $body");

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return GtinInformationModel.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      rethrow;
    }
  }
}
