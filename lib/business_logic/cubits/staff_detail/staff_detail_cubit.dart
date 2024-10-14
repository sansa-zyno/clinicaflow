import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_detail/staff_detail_state.dart';
import 'package:healtether_clinic_app/data_layer/services/staff_service/staff_service.dart';

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
