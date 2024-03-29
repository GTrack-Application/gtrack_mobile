// ignore_for_file: avoid_print

import 'package:gtrack_mobile_app/constants/app_preferences.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/capture/Association/Mapping/Sales_Order/GetSalesPickingListByAssignToUserIdAndPurchaseOrderModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPickingListController {
  static Future<List<GetSalesPickingListByAssignToUserIdAndPurchaseOrderModel>>
      getAllTable(String pickingRouteId) async {
    String? tokenNew;
    await AppPreferences.getToken().then((value) => tokenNew = value);
    String? userId;
    await AppPreferences.getUserId().then((value) => userId = value);

    String url =
        "${AppUrls.baseUrlWithPort}getSalesPickingListByAssignToUserIdAndPurchaseOrder?assign_to_user_id=$userId&purchase_order=$pickingRouteId";

    print(url);

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": tokenNew!,
      "Host": AppUrls.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        print("response: ${response.body}");

        var data = json.decode(response.body) as List;
        List<GetSalesPickingListByAssignToUserIdAndPurchaseOrderModel>
            shipmentData = data
                .map((e) =>
                    GetSalesPickingListByAssignToUserIdAndPurchaseOrderModel
                        .fromJson(e))
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
