import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/team/state/staff_detail_state.dart';
import 'package:clinica_flow/features/team/service/staff_service.dart';

class StaffDetailCubit extends Cubit<StaffDetailState> {
  StaffDetailCubit(this.service) : super(StaffDetailInitialState());

  StaffServices service;

  void fetchData(String id) {
    emit(StaffDetailLoadingState());

    service
        .getStaffById(id)
        .then((value) => emit(StaffDetailLoadedState(data: value)));
  }
}
