class ApiEndPoint {
  //static const String baseUrl = "https://api-uhi.azurewebsites.net/api";
  // static const String baseUrl = 'https://8pbjp9u8cw.ap-south-1.awsapprunner.com/api';
  static const String baseUrl = 'https://api-tst-clinic.healtether.com/api';
  static const String profilePicBaseUrl = 'https://doctorapptst.blob.core.windows.net/client1/staff/';
  static const String logoBaseUrl = 'https://doctorapptst.blob.core.windows.net/common/client/';
  static const String staffDocBaseUrl = 'https://doctorapptst.blob.core.windows.net/client1/staff/';
  static const String patientDocBaseUrl = 'https://doctorapptst.blob.core.windows.net/clinic662ca0a41a2431e16c41ebaa/patient/';

  static const String authLogin = '/authlogin';
  static String getStaffs({required String clinicId}) => '/staff/getstaffs?clientId=$clinicId';
  static String getPatients({required String clinicId}) => "/patient/getpatients?clientId=$clinicId";
  static String getPayments({required String clinicId}) => "/payment/getpayments?clientId=$clinicId&page=1&size=10&direction=asc";
  static String getAppointments({required String clinicId, required String status}) =>
      '/appointment/getappointments?clinicId=$clinicId&status=$status';
  static String getDoctors({required String clinicId}) => '/staff/getdoctorsbyclinic?clinicId=$clinicId';
  static String getDoctorsWithTimeSlots({required String clinicId}) => '/staff/getdoctorswithtime?clinicId=$clinicId';
  static String getFrequencyForPrescription({required String clinicId}) => '/frequency/getfrequenttextforfrescription?clinicId=$clinicId';
  static String getAppointmentCount({required String clinicId, required String date}) =>
      '/appointment/getappointmentcount?clinicId=$clinicId&date=$date';
  static String getPatientId({required String clinicId}) => '/clinic/getclinicpatientid?id=$clinicId';
  static String getStaffId({required String clinicId}) => '/clinic/getclinicstaffid?id=$clinicId';
  static String getNotifications({required String clinicId}) => '/notification/getnotification?page=1&size=10&direction=desc&clinicId=$clinicId';

  static String getClinicDetails({required String id}) => '/clinic/getclient?id=$id';
  static String getPrescriptionReport({required String appointmentId, required String clinicId}) =>
      '/appointment/write-prescription/getprescriptionforreport?clientId=$clinicId&appointment=$appointmentId';
  static String getStaffById({required String id}) => '/staff/getstaff?id=$id';
  static String deleteStaffById({required String id}) => '/staff/deletestaff?id=$id';
  static String getPatientById({required String id}) => "/patient/getpatient?id=$id";
  static String deletePatientById({required String id}) => '/patient/deletepatient?id=$id';
  //static String getFullPatientRecord({required String id}) => '/patient/getpatientlatestappointment?id=$id';
  static String getAppointmentById({required String id}) => '/appointment/getappointmentbyid?id=$id';
  //static String getTimeSlotsById({required String id}) => '/clinic/getclinictimeslots?id=$id';

  static String searchAllergies({required String query}) => '/appointment/write-prescription/searchmasterallergies?name=$query&limit=10';
  static String searchDrugs({required String query}) => '/appointment/write-prescription/searchmastermedication?name=$query&limit=10';

  static String postSymtomsAndDiagnostics({required String patientId, required String clientId, required String appointmentId}) =>
      '/appointment/write-prescription/upsertsymptomdiagnosis?patientId=$patientId&clientId=$clientId&appointmentId=$appointmentId';
  static String postVitals({required String patientId, required String clientId, required String appointmentId}) =>
      '/appointment/write-prescription/upsertvitals?patientId=$patientId&clientId=$clientId&appointmentId=$appointmentId';
  static String postMedicalHistory({required String patientId, required String clientId}) =>
      '/appointment/write-prescription/upsertmedicalhistory?patientId=$patientId&clientId=$clientId';
  static String postLabtests({required String patientId, required String clientId, required String appointmentId}) =>
      '/appointment/write-prescription/upsertlabtest?patientId=$patientId&clientId=$clientId&appointmentId=$appointmentId';
  static String postDrugs({required String patientId, required String clientId, required String appointmentId}) =>
      '/appointment/write-prescription/upsertdrugprescriptions?patientId=$patientId&clientId=$clientId&appointmentId=$appointmentId';

  static String getWholePrescriptions({required String appointmentId, required String clientId}) =>
      '/appointment/write-prescription/getwholeprescription?appointment=$appointmentId&clientId=$clientId';
  static String getPastMedicalHistory({required String patientId, required String clientId}) =>
      '/appointment/write-prescription/getwholemedicalhistories?patientId=$patientId&clientId=$clientId';
  static String getVitalsAndPersonalHistory({required String appointmentId, required String patientId}) =>
      '/appointment/write-prescription/getvitalsversonalHistory?appointmentId=$appointmentId&patientId=$patientId';
  static String getInvoiceById({required String invoiceId}) => '/payment/getinvoicebyid?id=$invoiceId';
  static String addInvoiceDetails({required String invoiceId, required String clinicId}) =>
      '/payment/addinvoiceformobile?id=$invoiceId&clientId=$clinicId';

  static const String createStaff = '/staff/upsert';
  static const String postPatient = '/patient/addpatient';
  static const String updatePatient = '/patient/updatepatient';
  static const String createAppointment = '/appointment/upsert';
  static const String getAgeRatio = '/analyatic/getAgeGroupRatio';
  static const String getPatientRatio = '/analyatic/getPatientAnalysis';
  static const String getGenderRatio = '/analyatic/getGenderRatio';
  static const String reSchedule = '/appointment/reschedule';
  static const String cancell = '/appointment/cancelled';
  static const String followUp = '/appointment/followup';
  static const String endConsultation = '/appointment/endconsultation';
  static const String makeReceipt = '/appointment/write-prescription/makereciept';
  static const String setCashPayment = '/payment/setcashpayment';

  static const String postMedicationDdx = "https://43.204.120.239:8000/ddx/medications";
  static const String createSymptoms = "https://43.204.120.239:8000/ddx/predict";
  static const String symptomsAndDiagnosisPredictionAI = 'https://ai.healtether.com/ddx/predict';

  //Messaging
  static const String msgBaseUrl = 'https://api-chats-tst-clinic.healtether.com/api';
  static const String sendWhatsappMsg = 'whatsappchat/addmessage';
  /*static String getWhatsappMsg({required String mobile, required String clinicId}) =>
      '/whatsappchat/getmessage?mobile=$mobile&clinicId=$clinicId&pg=1&pgSize=1';*/
  //static const String sendAppointmentSummary = '/message/sendappointmentsummary';
  // static const String sendPaymentLink = '/message/sendpaymentlink';
}
//id:65be5ecf4d5cb412fc374d60
//clientId/clinicId:662ca0a41a2431e16c41ebaa
