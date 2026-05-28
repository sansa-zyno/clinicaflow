// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../viewmodel/lab_test_cubit.dart';

class LabTestState {
  final LabTestStates state;
  final List<LabTest>? recommendedTests;
  final List<LabTest>? frequentlySearchedTests;
  final List<LabTest>? availableTests;
  final List<LabTest>? savedTests;
  LabTestState(
      {required this.state,
      this.availableTests = const [
        LabTest(name: "CBC"),
        LabTest(name: "Hemoglobin"),
        LabTest(name: "TSH"),
        LabTest(name: "TSH, T1, T2, T3"),
        LabTest(name: "CMC"),
        LabTest(name: "Lipid profile"),
        LabTest(name: "KIR"),
        LabTest(name: "KIDNEY"),
        LabTest(name: "Heart"),
        LabTest(name: "Liver"),
        LabTest(name: "Lungs"),
        LabTest(name: "Sugar level"),
      ],
      this.frequentlySearchedTests,
      this.recommendedTests,
      this.savedTests});

  LabTestState copyWith({
    LabTestStates? state,
    List<LabTest>? availableTests,
    List<LabTest>? recommendedTests,
    List<LabTest>? frequentlySearchedTests,
    List<LabTest>? savedTests,
  }) {
    return LabTestState(
        state: state ?? this.state,
        availableTests: availableTests ?? this.availableTests,
        recommendedTests: recommendedTests ?? this.recommendedTests,
        frequentlySearchedTests: frequentlySearchedTests ?? this.frequentlySearchedTests,
        savedTests: savedTests);
  }
}
