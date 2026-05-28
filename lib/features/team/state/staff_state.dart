// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../viewmodel/staff_cubit.dart';

class StaffState {
  final List<StaffModel>? staffList;
  // final bool isLoading;
  final StaffStates state;
  final String? errorMessage;
  final String? createStaffResponse;
  final List<Map<String, dynamic>>? doctors;
  StaffState({
    required this.state,
    this.errorMessage,
    this.createStaffResponse,
    this.staffList,
    this.doctors,
  });

  StaffState copyWith({
    StaffStates? state,
    String? errorMessage,
    String? createStaffResponse,
    List<StaffModel>? staffList,
    List<Map<String, dynamic>>? doctors,
  }) {
    return StaffState(
        state: state ?? this.state,
        errorMessage: errorMessage?.isEmpty == true
            ? null
            : errorMessage ?? this.errorMessage,
        createStaffResponse: createStaffResponse ?? this.createStaffResponse,
        staffList: staffList ?? this.staffList,
        doctors: doctors ?? this.doctors);
  }
}
