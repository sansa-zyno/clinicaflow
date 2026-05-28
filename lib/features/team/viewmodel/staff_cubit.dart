import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/team/model/staff_model.dart';
import 'package:clinica_flow/features/team/service/staff_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';

part '../state/staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffCubit() : super(StaffState(state: StaffStates.initial));

  StaffServices service = StaffServices();

  //? CREATE STAFF
  Future<void> createStaff(StaffModel staff, BuildContext context) async {
    emit(state.copyWith(state: StaffStates.creatingStaff));

    try {
      await service.createStaff(staff, context);

      emit(state.copyWith(state: StaffStates.staffCreated));
    } catch (error) {
      var errorMessage = error.toString();
      emit(state.copyWith(
          state: StaffStates.creatingStaffFailed, errorMessage: errorMessage));
    }
  }

  //? UPDATE STAFF
  Future<void> updateStaff(
      StaffModel staff, BuildContext context, String id) async {
    dev.log(staff.toJson(context).toString());
    emit(state.copyWith(state: StaffStates.creatingStaff));

    try {
      await service.updateStaff(staff, context, id);
      emit(state.copyWith(state: StaffStates.staffCreated));
    } catch (error) {
      var errorMessage = error.toString();
      dev.log(errorMessage);
      emit(state.copyWith(
          state: StaffStates.creatingStaffFailed, errorMessage: errorMessage));
    }
  }

  //? FETCH STAFF
  Future<void> fetchStaffs() async {
    emit(state.copyWith(state: StaffStates.fetchingStaff));
    List<StaffModel>? staff;
    try {
      staff = await service.fetchStaffs();
      // emit success response
      emit(state.copyWith(staffList: staff, state: StaffStates.staffFetched));
    } catch (error) {
      log('Failed to load data: $error');
      // emit failed response
      emit(state.copyWith(
          state: StaffStates.fetchingStaffFailed,
          errorMessage: 'Failed to load data'));
    }
  }

  //? DELETE STAFF
  Future<void> deleteStaff(String id) async {
    emit(state.copyWith(state: StaffStates.deletingStaff));
    try {
      await service.deleteStaff(id);
      emit(state.copyWith(state: StaffStates.staffDeleted));
    } catch (error) {
      log('Failed to delete staff: $error');
      emit(state.copyWith(state: StaffStates.deletingStaffFailed));
    }
  }

  fetchDoctors() async {
    try {
      List<Map<String, dynamic>>? doctors = await service.fetchDoctors();
      emit(state.copyWith(doctors: doctors));
    } catch (error) {
      log('Failed load doctors: $error');
    }
  }
}
