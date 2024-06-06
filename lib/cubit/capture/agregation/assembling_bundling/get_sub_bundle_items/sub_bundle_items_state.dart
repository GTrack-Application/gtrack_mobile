import 'package:gtrack_mobile_app/models/capture/aggregation/assembling_bundling/products_model.dart';

abstract class SubBundleItemsState {}

class SubBundleItemsInitial extends SubBundleItemsState {}

class SubBundleItemsLoading extends SubBundleItemsState {}

class SubBundleItemsLoaded extends SubBundleItemsState {
  final List<ProductsModel> items;

  SubBundleItemsLoaded({required this.items});
}

class SubBundleItemsError extends SubBundleItemsState {
  final String message;

  SubBundleItemsError({required this.message});
}
