abstract class PatientRatioState {}

class PatinetRatioInitialState extends PatientRatioState {}

class PatinetRatioLoadingState extends PatientRatioState {}

class PatinetRatioLoadedState extends PatientRatioState {
  final dynamic data;

  PatinetRatioLoadedState({required this.data});
}

class PatinetRatioErrorState extends PatientRatioState {}
