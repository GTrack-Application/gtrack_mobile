// ignore_for_file: file_names

import 'dart:convert';

import 'package:gtrack_mobile_app/constants/app_preferences.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/reveiving/supplier_receipt/BinToBinInternalModel.dart';
import 'package:http/http.dart' as http;

class GetItemNameByItemIdController {
  static Future<List<BinToBinInternalModel>> getName(String itemId) async {
    String? tokenNew;
    await AppPreferences.getToken().then((value) => tokenNew = value);

    String url =
        "${AppUrls.baseUrlWithPort}getOneMapBarcodeDataByItemCode?ItemCode=$itemId";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": tokenNew!,
      "Host": AppUrls.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        List<BinToBinInternalModel> allData =
            data.map((e) => BinToBinInternalModel.fromJson(e)).toList();
        return allData;
      } else {
        throw Exception("No Data Found");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
