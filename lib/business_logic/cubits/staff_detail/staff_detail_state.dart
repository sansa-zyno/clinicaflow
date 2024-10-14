// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';

abstract class StaffDetailState {}

class StaffDetailInitialState extends StaffDetailState {}

class StaffDetailLoadingState extends StaffDetailState {}

class StaffDetailLoadedState extends StaffDetailState {
  StaffByIdModel data;
  StaffDetailLoadedState({
    required this.data,
  });
}
