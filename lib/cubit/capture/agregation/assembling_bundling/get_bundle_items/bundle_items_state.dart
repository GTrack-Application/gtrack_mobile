import 'package:gtrack_mobile_app/models/capture/aggregation/assembling_bundling/BundleItemsModel.dart';

abstract class BundleItemsState {}

class BundleItemsInitial extends BundleItemsState {}

class BundleItemsLoading extends BundleItemsState {}

class BundleItemsLoaded extends BundleItemsState {
  final List<BundleItemsModel> items;
  BundleItemsLoaded({required this.items});
}

class AssembleItemsLoaded extends BundleItemsState {
  final List<AssembleItemsModel> items;
  AssembleItemsLoaded({required this.items});
}

class BundleItemsError extends BundleItemsState {
  final String message;
  BundleItemsError({required this.message});
}
