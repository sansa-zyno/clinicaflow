enum StaffStates {
  initial,
  //? CREATING STAFF
  creatingStaff,
  staffCreated,
  creatingStaffFailed,
  //? FETCHING STAFF
  fetchingStaff,
  staffFetched,
  fetchingStaffFailed,
  //? DELETING STAFF
  deletingStaff,
  staffDeleted,
  deletingStaffFailed,
}

enum AppointmentStates {
  initial,
  //? CREATING APPOINTMENT
  creatingAppointments,
  appointmentsCreated,
  creatingAppointmentsFailed,
  //? FETCHING APPOINTMENT
  fetchingAppointments,
  appointmentsFetched,
  fetchingAppointmentsFailed,
}

enum PaymentStates {
  initial,
  //? FETCHING PAYMENTS
  fetchingPayments,
  paymentsFetched,
  fetchingPaymentsFailed,
}

enum PatientRecordsStates {
  initial,
  //? CREATING PATIENT
  postingPatient,
  patientPosted,
  postingPatientFailed,
  //? FETCHING PATIENT
  fetchingPatients,
  patientsFetched,
  fetchingPatientsFailed,
  //? DELETING PATIENT
  deletingPatient,
  patientDeleted,
  deletingPatientFailed,
}

enum CreateSymptomsStates {
  initial,
  //? CREATING SYMPTOMS
  postingSymptoms,
  symptomsPosted,
  postingSymptomsFailed,
}

enum MedicationStates {
  initial,
  //? CREATING MEDICATIONS
  creatingMedication,
  medicationsCreated,
  creatingMedicationFailed,
  //? SEARCHING MEDICATIONS
  searchingMedications,
  searchingMedicationsSuccess,
  searchingMedicationsFailed,

  diagnosesUpdated,
  nMedicationsUpdated,
}

enum AppointmentDataStates {
  initial,
  appointmentAdded,
  appointmentDeleted,
}

enum SettingsStates {
  initial,
  useAiPredictiveSearchUpdated,
  previewPrescriptionbeforePrintUpdated,
  notifyUserOnWhatsappUpdated,
  templateFormDataUpdated;

  String get describe => name;

  static SettingsStates fromString(String value) {
    switch (value) {
      case 'useAiPredictiveSearchUpdated':
        return SettingsStates.useAiPredictiveSearchUpdated;
      case 'previewPrescriptionbeforePrintUpdated':
        return SettingsStates.previewPrescriptionbeforePrintUpdated;
      case 'notifyUserOnWhatsappUpdated':
        return SettingsStates.notifyUserOnWhatsappUpdated;
      default:
        return SettingsStates.initial;
    }
  }
}

enum PastHistoryStates {
  initial,
  //? CREATING PASTHISTORY
  creatingHistory,
  historyCreated,
  creatingHistoryFailed,
  //? FETCHING PASTHISTORY
  fetchingHistory,
  historyFetched,
  fetchingHistoryFailed,
  //? UPDATING PASTHISTORY
  updatingHistory,
  historyUpdated,
  updatingHistoryFailed,
  //? DELETING PASTHISTORY
  deletingHistory,
  historyDeleted,
  deletingHistoryFailed,
}

enum VitalsStates {
  initial,
  //? CREATING VITALS
  addingVital,
  vitalAdded,
  addingVitalFailed,
  //? FETCHING VITALS
  vitalsFetched,
  fetchingVitals,
  fetchingVitalsFailed,
  //? UPDATING VITALS
  updatingVital,
  vitalUpdated,
  updatingVitalFailed,
  //? DELETING VITALS
  deletingVital,
  vitalDeleted,
  deletingVitalFailed,
}

enum PastProcedureStates {
  initial,
}

enum Medicationstates {
  initial,
}

enum AllergyStates {
  initial,
  //? SEARCHING ALLERGIES
  searchingForAllergies,
  searchingForAllergiesSuccess,
  searchingForAllergiesFailed,
}

enum LabTestStates {
  initial,
  //? FETCHING FREQUENTLY SEARCHED TESTS
  fetchingFrequentlySearchedTests,
  frequentlySearchedTestsFetched,
  frequentlySearchedTestsFailed,
  //? SEARCHING FREQUENTLY SEARCHED TESTS
  searchingForTests,
  searchingForTestsSuccess,
  searchingForTestsFailed,
}

enum SymptomsAndDiagnosisStates {
  initial,
  //FETCHING FREQUENTLY SEARCHED SYMPTOMS
  fetchingFrequentlySearchedSymptoms,
  frequentlySearchedSymptomsFetched,
  frequentlySearchedSymptomsFailed,

  searchingSymptomAndPredictionForddx,
  symptomAndPredictionForddxFetched,
  searchingSymptomAndPredictionForddxFailed,
}

enum DrugPrescriptionStates {
  initial,
  savingDrugs,
  drugsSaved,
  fetchingSavedDrugs,
  clearingSavedDrugs,
  savedDrugsCleared,
  removingDrug,
  drugRemoved,
  //? FETCHING FREQUENTLY SEARCHED DRUGS
  fetchingFrequentlySearchedDrugs,
  frequentlySearchedDrugsFetched,
  frequentlySearchedDrugsFailed,
  //? SEARCHING DRUGS
  searchingForDrugs,
  searchingForDrugsSuccess,
  searchingForDrugsFailed,
}
