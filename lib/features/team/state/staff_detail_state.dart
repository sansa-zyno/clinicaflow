// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinica_flow/features/team/model/staff_model.dart';

abstract class StaffDetailState {}

class StaffDetailInitialState extends StaffDetailState {}

class StaffDetailLoadingState extends StaffDetailState {}

class StaffDetailLoadedState extends StaffDetailState {
  StaffModel data;
  StaffDetailLoadedState({
    required this.data,
  });
}
