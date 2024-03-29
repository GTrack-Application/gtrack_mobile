// ignore_for_file: file_names

import 'dart:convert';

import 'package:gtrack_mobile_app/constants/app_preferences.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:http/http.dart' as http;

class GenerateSerialNumberforRecevingController {
  static Future<String> generateSerialNo(String itemId) async {
    String? tokenNew;
    await AppPreferences.getToken().then((value) => tokenNew = value);

    String url = "${AppUrls.baseUrlWithPort}generateSerialNumberforReceving";

    final body = {"ITEMID": itemId};

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": tokenNew!,
      "Host": AppUrls.host,
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var serialNo = data['SERIALNO'];
        return serialNo;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
