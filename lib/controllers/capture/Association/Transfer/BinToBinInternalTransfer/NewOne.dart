// ignore_for_file: camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:gtrack_mobile_app/constants/app_preferences.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/capture/Association/Mapping/Sales_Order/getMappedBarcodedsByItemCodeAndBinLocationModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewOne {
  static Future<List<getMappedBarcodedsByItemCodeAndBinLocationModel>> getData(
    String itemCode,
    String binLocation,
  ) async {
    String? tokenNew;
    await AppPreferences.getToken().then((value) => tokenNew = value);

    String url =
        "${AppUrls.baseUrlWithPort}getMappedBarcodedsByItemCodeAndBinLocation";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": tokenNew!,
      "Host": AppUrls.host,
      "Accept": "application/json",
      "itemcode": itemCode,
      "binlocation": binLocation,
    };

    print(headers);

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<getMappedBarcodedsByItemCodeAndBinLocationModel> shipmentData =
            data
                .map((e) =>
                    getMappedBarcodedsByItemCodeAndBinLocationModel.fromJson(e))
                .toList();
        return shipmentData;
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
