import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_mobile_app/constants/app_preferences.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/models/capture/Association/Receiving/raw_materials/direct_receipt/ShipmentDataModel.dart';
import 'package:gtrack_mobile_app/models/capture/Association/item_details/asset_details_model.dart';
import 'package:http/http.dart' as http;

part 'item_details_states.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit() : super(ItemDetailsInitial());

  static ItemDetailsCubit get(context) => BlocProvider.of(context);

  // * Direct Receipt
  TextEditingController shipmentIdController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController manufactureDateController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController transpoGLNController = TextEditingController();
  TextEditingController putAwayLocation = TextEditingController();
  String? glnIdFrom;
  String? typeOfTransaction;

  void saveItemDetails(ShipmentDataModel shipmentModel) async {
    emit(ItemDetailsLoading());
    try {
      // * Success
      String? userId = await AppPreferences.getUserId();
      // String? token = await AppPreferences.getToken();
      // String url = "${AppUrls.baseUrlWith3091}api/products";

      const url = "${AppUrls.baseUrlWith7000}/api/addTransaction";

      final uri = Uri.parse(url);

      final headers = <String, String>{
        "Content-Type": "application/json",
        "Host": AppUrls.host,
      };

      var body;
      if (assets.isNotEmpty) {
        body = {
          "userId": userId.toString(),
          "typeOfTransaction": typeOfTransaction.toString(),
          "glnIdFrom": glnIdFrom.toString(),
          "glnIdTo": putAwayLocation.text.trim(),
          "refNum": shipmentIdController.text.trim(),
          "transpoGLN": transpoGLNController.text.trim(),
          "status": "Picked",
          "details": {
            "GTIN": shipmentModel.barcode.toString(),
            "ProductNameEn": shipmentModel.productnameenglish.toString(),
            "ProductNameAr": shipmentModel.productnamearabic.toString(),
            "BrandName": shipmentModel.brandName.toString(),
            "Batch": batchNoController.text.trim(),
            "NetWeight": netWeightController.text.trim(),
            "UnitOfMeasure": unitController.text.trim(),
            "Quantity": quantityController.text.trim(),
            "SSCC": "",
            "ManufacturingDate": manufactureDateController.text.trim(),
            "ExpiryDate": expiryDateController.text.trim(),
            "TranspoGLN": transpoGLNController.text.trim(),
          },
          "assets": assets
              .map((asset) => {
                    "AssetIdNo": asset.assetId,
                    "TagNo": asset.tagNo,
                    "AssetDescription": asset.description,
                    "AssetClass": asset.assetClass,
                    "AssetGLNLocation": asset.location
                  })
              .toList()
        };
      } else {
        body = {
          "userId": userId.toString(),
          "typeOfTransaction": typeOfTransaction.toString(),
          "glnIdFrom": glnIdFrom.toString(),
          "glnIdTo": putAwayLocation.text.trim(),
          "refNum": shipmentIdController.text.trim(),
          "transpoGLN": transpoGLNController.text.trim(),
          "status": "Picked",
          "details": {
            "GTIN": shipmentModel.barcode.toString(),
            "ProductNameEn": shipmentModel.productnameenglish.toString(),
            "ProductNameAr": shipmentModel.productnamearabic.toString(),
            "BrandName": shipmentModel.brandName.toString(),
            "Batch": batchNoController.text.trim(),
            "NetWeight": netWeightController.text.trim(),
            "UnitOfMeasure": unitController.text.trim(),
            "Quantity": quantityController.text.trim(),
            "SSCC": "",
            "ManufacturingDate": manufactureDateController.text.trim(),
            "ExpiryDate": expiryDateController.text.trim(),
            "TranspoGLN": transpoGLNController.text.trim(),
          }
        };
      }

      var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      log(jsonEncode(body));
      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ItemDetailsSuccess());
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      emit(ItemDetailsError(e.toString()));
    }
  }

  // * Asset Details
  final TextEditingController assetIdController = TextEditingController();
  final TextEditingController tagNoController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void clearTextFields() {
    assetIdController.clear();
    tagNoController.clear();
    descriptionController.clear();
    classController.clear();
    locationController.clear();
  }

  bool isEmptyTextField() {
    if (assetIdController.text.isEmpty ||
        tagNoController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        classController.text.isEmpty ||
        locationController.text.isEmpty) {
      emit(ItemDetailsAssetDetailsError("Please fill all the fields"));
      return true;
    }
    return false;
  }

  List<AssetDetailsModel> assets = [];

  void addAssetDetails() {
    emit(ItemDetailsAssetDetailsLoading());
    try {
      // * Success
      emit(ItemDetailsAssetDetailsSuccess(AssetDetailsModel(
        assetId: assetIdController.text.trim(),
        tagNo: tagNoController.text.trim(),
        description: descriptionController.text.trim(),
        assetClass: classController.text.trim(),
        location: locationController.text.trim(),
      )));
    } catch (e) {
      // ! Error
      emit(ItemDetailsAssetDetailsError(e.toString()));
    }
  }

  void deleteAsset(index) {
    emit(ItemDetailsAssetDetailsLoading());
    try {
      // * Success
      assets.removeAt(index);
    } catch (e) {
      // ! Error
      emit(ItemDetailsAssetDetailsError(e.toString()));
    }
  }

  void clearEverything() {
    emit(ItemDetailsInitial());
    shipmentIdController.clear();
    quantityController.clear();
    batchNoController.clear();
    expiryDateController.clear();
    manufactureDateController.clear();
    netWeightController.clear();
    unitController.clear();
    transpoGLNController.clear();
    putAwayLocation.clear();
    glnIdFrom = null;
    typeOfTransaction = null;
    assetIdController.clear();
    tagNoController.clear();
    descriptionController.clear();
    classController.clear();
    locationController.clear();
    assets.clear();
  }
}
