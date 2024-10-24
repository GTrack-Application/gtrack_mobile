import 'package:gtrack_mobile_app/models/IDENTIFY/SSCC/SsccModel.dart';

abstract class SsccState {}

class SsccInitState extends SsccState {}

class SsccLoadingState extends SsccState {}

class SsccLoadedState extends SsccState {
  List<SsccModel> data = [];

  SsccLoadedState({required this.data});
}

class SsccErrorState extends SsccState {
  final String message;

  SsccErrorState({required this.message});
}
