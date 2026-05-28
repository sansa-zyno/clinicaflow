// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class PatientGenderRatioState {}

class PatinetGenderRatioInitialState extends PatientGenderRatioState {}

class PatinetGenderRatioLoadingState extends PatientGenderRatioState {}

class PatinetGenderRatioLoadedState extends PatientGenderRatioState {
  List<int> data;
  PatinetGenderRatioLoadedState({
    required this.data,
  });
}

class PatinetGenderRatioErrorState extends PatientGenderRatioState {}
