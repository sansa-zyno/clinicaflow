import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/lab_test/model/lab_tests.dart';
import 'package:clinica_flow/core/constants/sample_objects/sample_objects.dart';
import 'package:clinica_flow/features/lab_test/service/lab_test_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';

part '../state/lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  LabTestCubit() : super(LabTestState(state: LabTestStates.initial));

  LabTestService service = LabTestService();

  //? ADD LAB TEST APIS HERE
  /*//? fetch recommendedTests
  void fetchRecommendedTests() {
    emit(state.copyWith(state: LabTestStates.fetchingRecommendedTests));

    //TODO: ADD LOGIC HERE

    emit(state.copyWith(state: LabTestStates.recommendedTestsFetched));
  }*/

  //? fetch frequentlySearchedTests
  void fetchFrequentlySearchedTests() async {
    emit(state.copyWith(
        state: LabTestStates.fetchingFrequentlySearchedTests,
        savedTests: state.savedTests));

    try {
      List<LabTest> labTests = await service.getFrequentlySearchedTests();

      emit(state.copyWith(
          state: LabTestStates.frequentlySearchedTestsFetched,
          frequentlySearchedTests: labTests,
          savedTests: state.savedTests));
    } catch (error) {
      log('Failed to load tests: $error');

      emit(state.copyWith(
          state: LabTestStates.frequentlySearchedTestsFailed,
          savedTests: state.savedTests));
    }
  }

  void searchTests(String query) {
    emit(state.copyWith(
        state: LabTestStates.searchingForTests, savedTests: state.savedTests));
    //TODO: ADD LOGIC HERE
    try {
      emit(state.copyWith(
          state: LabTestStates.searchingForTestsSuccess,
          availableTests: SampleObjects.availableTests.where((element) {
            final regex = RegExp(query, caseSensitive: false);
            return regex.hasMatch(element.name);
          }).toList(),
          savedTests: state.savedTests));
    } catch (e) {
      emit(state.copyWith(
          state: LabTestStates.searchingForTestsFailed,
          savedTests: state.savedTests));
    }
  }

  postLabTest(
      {required String patientId,
      required String appointmentId,
      required List<Map<String, dynamic>> labTest}) async {
    emit(state.copyWith(
        state: LabTestStates.postingLabTests, savedTests: state.savedTests));
    try {
      await service.postLabTest(
          patientId: patientId,
          appointmentId: appointmentId,
          labTests: labTest);
      emit(state.copyWith(
          state: LabTestStates.labTestsPosted, savedTests: state.savedTests));
    } catch (error) {
      log('Failed to load ddxPredictions: $error');

      emit(state.copyWith(
          state: LabTestStates.postingLabTestsFailed,
          savedTests: state.savedTests));
    }
  }

  getSavedLabTests({required String appointmentId}) async {
    emit(state.copyWith(state: LabTestStates.fetchingSavedTests));
    try {
      List<LabTest>? result =
          await service.getSavedLabTests(appointmentId: appointmentId);
      emit(state.copyWith(
        state: LabTestStates.savedTestsFetched,
        savedTests: result,
      ));
    } catch (error) {
      log('Failed to fetch saved Tests: $error');
      emit(state.copyWith(state: LabTestStates.savedTestsFailed));
    }
  }
}
