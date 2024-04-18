// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/share/product_information/gtin_information_model.dart';
import 'package:http/http.dart' as http;

class GtinInformationController {
  static Future<dynamic> getGtinInformation(String gtin) async {
    final url = Uri.parse(
        "${AppUrls.baseUrl}api/foreignGtin/getGtinProductDetails?barcode=0000030079236");

    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print(response.body);

      if (data['ProductDataAvailable'] == true) {
        return GtinInformationDataModel.fromJson(data);
      } else {
        return GtinInformationModel.fromJson(data);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
