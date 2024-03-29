import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_mobile_app/blocs/global/global_states_events.dart';
import 'package:gtrack_mobile_app/controllers/capture/Association/Transfer/WIPtoFG/wip_to_fg_controller.dart';
import 'package:gtrack_mobile_app/models/capture/Association/Transfer/WipToFG/get_items_ln_wips_model.dart';

class WipToFGBloc extends Bloc<GlobalEvent, GlobalState> {
  WipToFGBloc() : super(GlobalInitState()) {
    on<GlobalInitEvent>((event, emit) async {
      List<GetItemsLnWipsModel> items = [];
      emit(GlobalLoadingState());
      try {
        items = await WIPToFgController.getItems();
        if (items.isEmpty) {
          emit(GlobalLoadedState(data: []));
        } else {
          emit(GlobalLoadedState(data: items));
        }
      } catch (e) {
        emit(GlobalErrorState(message: "Failed to load data"));
      }
    });
  }
}
