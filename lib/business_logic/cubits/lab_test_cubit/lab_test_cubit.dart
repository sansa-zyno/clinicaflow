import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/lab_tests/lab_tests.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/data_layer/services/lab_test_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';

part 'lab_test_state.dart';

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
    emit(state.copyWith(state: LabTestStates.fetchingFrequentlySearchedTests));

    try {
      List<LabTest> labTests = await service.getFrequentlySearchedTests();

      emit(state.copyWith(state: LabTestStates.frequentlySearchedTestsFetched, frequentlySearchedTests: labTests));
    } catch (error) {
      log('Failed to load tests: $error');

      emit(state.copyWith(state: LabTestStates.frequentlySearchedTestsFailed));
    }
  }

  void searchTests(String query) {
    emit(state.copyWith(state: LabTestStates.searchingForTests));
    //TODO: ADD LOGIC HERE
    try {
      emit(state.copyWith(
          state: LabTestStates.searchingForTestsSuccess,
          availableTests: SampleObjects.availableTests.where((element) {
            final regex = RegExp(query, caseSensitive: false);

            return regex.hasMatch(element.name);
          }).toList()));
    } catch (e) {
      emit(state.copyWith(state: LabTestStates.searchingForTestsFailed));
    }
  }

  postLabTest({required String patientId, required String appointmentId, required List labTest}) async {
    emit(state.copyWith(state: LabTestStates.postingLabTests));
    try {
      String message = await service.postLabTest(patientId: patientId, appointmentId: appointmentId, labTests: labTest);
      emit(state.copyWith(
        state: LabTestStates.labTestsPosted,
      ));
    } catch (error) {
      log('Failed to load ddxPredictions: $error');

      emit(state.copyWith(state: LabTestStates.postingLabTestsFailed));
    }
  }

  getSavedLabTests({required String appointmentId}) async {
    emit(state.copyWith(state: LabTestStates.fetchingSavedTests));
    try {
      List<LabTest>? result = await service.getSavedLabTests(appointmentId: appointmentId);
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
