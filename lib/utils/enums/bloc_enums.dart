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
  //? FETCHING APPOINTMENTs
  fetchingAppointments,
  appointmentsFetched,
  fetchingAppointmentsFailed,
  //? RESCHEDULLING APPOINTMENT
  reschedulingAppointment,
  appointmentRescheduled,
  reschedulingAppointmentFailed,
  //? CANCELLING APPOINTMENT
  cancellingAppointment,
  appointmentCancelled,
  cancellingAppointmentFailed,
  //? FOLLOWUP APPOINTMENT
  followingupAppointment,
  appointmentFollowedup,
  followingupAppointmentFailed,
  //? FETCHING APPOINTMENT BY ID
  fetchingAppointmentById,
  appointmentByIdFetched,
  fetchingAppointmentByIdFailed,
  //? FETCHING APPOINTMENT COUNT
  fetchingAppointmentCount,
  appointmentCountFetched,
  fetchingAppointmentCountFailed,
  //? ENDING CONSULTATION
  endingConsultation,
  consultationEnded,
  endingConsultationFailed,
  //? ADDING INVOICE
  addingInvoice,
  invoiceAdded,
  addingInvoiceFailed,
  //? GETTING INVOICE
  fetchingInvoice,
  invoiceFetched,
  fetchingInvoiceFailed
}

enum PaymentStates {
  initial,
  //? FETCHING PAYMENTS
  fetchingPayments,
  paymentsFetched,
  fetchingPaymentsFailed,
  //? ADDING PAYMENT
  addingPayment,
  paymentAdded,
  addingPaymentFailed,
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

/*enum CreateSymptomsStates {
  initial,
  //? CREATING SYMPTOMS
  postingSymptoms,
  symptomsPosted,
  postingSymptomsFailed,
}*/

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
  postingVitals,
  vitalsPosted,
  postingVitalsFailed,
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
  //? CREATING LAB TESTS
  postingLabTests,
  labTestsPosted,
  postingLabTestsFailed,
  //? FETCHING FREQUENTLY SEARCHED TESTS
  fetchingFrequentlySearchedTests,
  frequentlySearchedTestsFetched,
  frequentlySearchedTestsFailed,
  //? FETCHING SAVED TESTS
  fetchingSavedTests,
  savedTestsFetched,
  savedTestsFailed,
  //? SEARCHING FREQUENTLY SEARCHED TESTS
  searchingForTests,
  searchingForTestsSuccess,
  searchingForTestsFailed,
}

enum SymptomsAndDiagnosisStates {
  initial,
  //? CREATING SYMPTOMS
  postingSymptomsAndDiagnosis,
  symptomsAndDiagnosisPosted,
  postingSymptomsAndDiagnosisFailed,

  //FETCHING FREQUENTLY SEARCHED SYMPTOMS
  fetchingFrequentlySearchedSymptoms,
  frequentlySearchedSymptomsFetched,
  frequentlySearchedSymptomsFailed,

  //FETCHING SAVED SYMPTOMS
  fetchingSavedSymptomsAndDiagnosis,
  savedSymptomsAndDiagnosisFetched,
  savedSymptomsAndDiagnosisFailed,

  fetchingSymptomAndPredictionForddx,
  symptomAndPredictionForddxFetched,
  fetchingSymptomAndPredictionForddxFailed,
}

enum DrugPrescriptionStates {
  initial,
  //? CREATING DRUG PRESCRIPTION
  postingDrugPrescription,
  drugPrescriptionPosted,
  postingDrugPrescriptionFailed,
  //? FETCHING FREQUENTLY SEARCHED DRUGS
  fetchingFrequentlySearchedDrugs,
  frequentlySearchedDrugsFetched,
  frequentlySearchedDrugsFailed,
  //? FETCHING SAVED DRUG PRESCRIPTION
  fetchingSavedDrugPrescription,
  savedDrugPrescriptionFetched,
  savedDrugPrescriptionFailed,
  //? SEARCHING DRUGS
  searchingForDrugs,
  searchingForDrugsSuccess,
  searchingForDrugsFailed,
}

enum PastMedicalHistoryStates {
  initial,
  //? CREATING PAST MEDICAL HISTORY
  postingPastMedicalHistory,
  pastMedicalHistoryPosted,
  postingPastMedicalHistoryFailed,

  //? FETCHING PAST MEDICAL HISTORY
  fetchingPastMedicalHistory,
  pastMedicalHistoryFetched,
  fetchingPastMedicalHistoryFailed,
}

enum WhatsappMessagingStates {
  initial,
  //? SENDING MESSAGES
  sendingMessage,
  sendingMessageDone,
  sendingMessageFailed
}

enum NotificationStates {
  initial,
  fetchingNotifications,
  notificationsFetched,
  fetchingNotificationsFailed,
}

enum PrescriptionReportStates {
  initial,
  fetchingReport,
  reportFetched,
  fetchingReportFailed,
}
