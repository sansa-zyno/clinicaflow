// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../viewmodel/drug_prescription_cubit.dart';

class DrugPrescriptionState {
  final DrugPrescriptionStates state;
  final String? message;
  final AppError? error;
  final List<Drug>? frequentlySearchedDrugs; // this field stores the frequently searched drugs
  final List<Drug>? suggestedDrugs; // this field stores the suggested drugs
  final List<Drug>? drugs; // this field stores the result of drug search
  final Map<String, dynamic>? savedDrugPrescription; // this field stores the drugs saved by the doctor: key= patientId, value: List<Drugs>
  DrugPrescriptionState({
    required this.state,
    this.message,
    this.error,
    this.frequentlySearchedDrugs,
    this.suggestedDrugs,
    this.drugs,
    this.savedDrugPrescription,
  });

  DrugPrescriptionState copyWith(
      {DrugPrescriptionStates? state,
      String? message,
      AppError? error,
      frequentlySearchedDrugs,
      List<Drug>? suggestedDrugs,
      List<Drug>? drugs,
      Map<String, dynamic>? savedDrugPrescription}) {
    return DrugPrescriptionState(
      state: state ?? this.state,
      message: message ?? this.message,
      error: error ?? this.error,
      frequentlySearchedDrugs: frequentlySearchedDrugs ?? this.frequentlySearchedDrugs,
      suggestedDrugs: suggestedDrugs ?? this.suggestedDrugs,
      drugs: drugs ?? this.drugs,
      savedDrugPrescription: savedDrugPrescription,
    );
  }

  @override
  String toString() {
    return 'DrugPrescriptionState(state: $state, message: $message, error: $error, frequentlySearchedDrugs: $frequentlySearchedDrugs, suggestedDrugs: $suggestedDrugs, drugs: $drugs, savedDrugs: $savedDrugPrescription)';
  }
}
