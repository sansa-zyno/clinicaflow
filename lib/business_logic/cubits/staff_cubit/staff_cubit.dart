import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';
import 'package:healtether_clinic_app/data_layer/services/staff_service/staff_service.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffCubit() : super(StaffState(state: StaffStates.initial));

  StaffServices service = StaffServices();

  //? CREATE STAFF
  Future<void> createStaff(CreateStaff createStaff, BuildContext context) async {
    emit(state.copyWith(state: StaffStates.creatingStaff));

    try {
      var createStaffResponse = await service.createStaff(createStaff, context);

      emit(state.copyWith(createStaffResponse: createStaffResponse, state: StaffStates.staffCreated));
    } catch (error) {
      var errorMessage = error.toString();
      emit(state.copyWith(state: StaffStates.creatingStaffFailed, errorMessage: errorMessage));
    }
  }

  //? UPDATE STAFF
  Future<void> updateStaff(CreateStaff createStaff, BuildContext context, String id) async {
    dev.log(createStaff.toJson(context).toString());
    emit(state.copyWith(state: StaffStates.creatingStaff));

    try {
      var createStaffResponse = await service.updateStaff(createStaff, context, id);
      emit(state.copyWith(createStaffResponse: createStaffResponse, state: StaffStates.staffCreated));
    } catch (error) {
      var errorMessage = error.toString();
      dev.log(errorMessage);
      emit(state.copyWith(state: StaffStates.creatingStaffFailed, errorMessage: errorMessage));
    }
  }

  //? FETCH STAFF
  Future<void> fetchStaffs() async {
    emit(state.copyWith(state: StaffStates.fetchingStaff));
    List<Staff>? staff;
    try {
      staff = await service.fetchStaffs();
      // emit success response
      emit(state.copyWith(staffList: staff, state: StaffStates.staffFetched));
    } catch (error) {
      log('Failed to load data: $error');
      // emit failed response
      emit(state.copyWith(state: StaffStates.fetchingStaffFailed, errorMessage: 'Failed to load data'));
    }
  }

  //? DELETE STAFF
  Future<void> deleteStaff(String id) async {
    emit(state.copyWith(state: StaffStates.deletingStaff));
    try {
      await service.deleteStaff(id);
      // delete staff from state
      //final newStaffList = state.staffList == null ? null : [...?state.staffList];
      //newStaffList?.removeWhere((staff) => staff.staffId == id);
      //emit(state.copyWith(staffList: newStaffList));
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
