import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/features/payment/model/invoice.dart'
    hide Appointment;
import 'package:clinica_flow/core/network/http.service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

class AppointmentServices {
  String token = "";
  String clinicId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<AppointmentModel> fetchAppointments({required String status}) async {
    await fetchToken();

    try {
      final querySnapshot = await _firestore
          .collection('appointments')
          .where('clientId', isEqualTo: clinicId)
          .where('status', isEqualTo: status)
          .get();
      final appointments = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Appointment.fromJson(data);
      }).toList();
      return AppointmentModel(
        data: appointments,
        totalCount: appointments.length,
      );
    } catch (e) {
      log('Exception during fetchAppointments: $e');
      throw 'Failed to load appointments: $e';
    }
  }

  Future<String> bookAppointment({
    required String mobile,
    required String name,
    required String gender,
    required String age,
    required String birthDate,
    required String appointmentDate,
    required String timeSlot,
    required String reason,
    required String virtualConsultation,
    required String patientId,
    required String doctorId,
    required String doctorName,
    required String clinicPatientId,
  }) async {
    await fetchToken();
    Map<String, dynamic> body = {
      'data': {
        'mobile': mobile,
        'name': name,
        'gender': gender,
        'age': age,
        'birthDate': birthDate,
        'appointmentDate': appointmentDate,
        'timeSlot': timeSlot,
        'reason': reason,
        'virtualConsultation': virtualConsultation,
        'patientId': patientId,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'clientId': clinicId,
        "clinicPatientId": clinicPatientId
      }
    };
    final response = await HttpService.post(
      ApiEndPoint.createAppointment,
      token,
      body,
    );

    if (response.statusCode == 200) {
      log('Appointment created successfully.');
      return response.data['data']['id'];
    } else {
      log('Failed to create appointment: ${response.data}');
      return '';
    }
  }

  Future<List<Map<String, dynamic>>> fetchDoctorsWithTimeSlots() async {
    await fetchToken();
    final response = await HttpService.get(
        ApiEndPoint.getDoctorsWithTimeSlots(clinicId: clinicId), token);
    if (response.statusCode == 200) {
      final data = response.data;
      List<Map<String, dynamic>> doctorsList =
          List<Map<String, dynamic>>.from(data);
      log(doctorsList.toString());
      return doctorsList;
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<String?> reScheduleAppointment(
      {required String id,
      required String appointmentDate,
      required String timeSlot}) async {
    await fetchToken();
    final response = await HttpService.post(ApiEndPoint.reSchedule, token, {
      "data": {
        "id": id,
        "appointmentDate": appointmentDate,
        "timeSlot": timeSlot,
      }
    });
    if (response.statusCode == 200) {
      //log(response.data.toString());
      return response.data['description'];
    } else {
      throw Exception('Failed to reschedule appointment');
    }
  }

  Future<String?> cancellAppointment({required String id}) async {
    await fetchToken();
    final response = await HttpService.post(ApiEndPoint.cancell, token, {
      "data": {
        "id": id,
      }
    });
    if (response.statusCode == 200) {
      // log(response.data.toString());
      return response.data['description'];
    } else {
      throw Exception('Failed to cancell appointment');
    }
  }

  Future<String?> followupAppointment(
      {required String id,
      required String appointmentDate,
      required String timeSlot}) async {
    await fetchToken();
    final response = await HttpService.post(ApiEndPoint.followUp, token, {
      "data": {
        "id": id,
        "appointmentDate": appointmentDate,
        "timeSlot": timeSlot,
      }
    });
    if (response.statusCode == 200) {
      //log(response.data.toString());
      return response.data['description'];
    } else {
      throw Exception('Failed to follow up appointment');
    }
  }

  Future<Appointment> getAppointmentById({required String id}) async {
    await fetchToken();
    try {
      final response =
          await HttpService.get(ApiEndPoint.getAppointmentById(id: id), token);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        return Appointment.fromJson(jsonResponse);
      } else {
        log('Failed to get appointment details: ${response.statusCode}');
        throw 'Failed to get appointment details: ${response.statusCode}';
      }
    } catch (e) {
      log('Exception during getAppointmentById: $e');
      throw 'Failed to get appointment details: $e';
    }
  }

  Future<Map> getCompletedAndRemainingAppointmentCount(
      {required String date}) async {
    await fetchToken();
    try {
      final response = await HttpService.get(
          ApiEndPoint.getAppointmentCount(clinicId: clinicId, date: date),
          token);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        return {
          'received': jsonResponse['received'],
          'completed': jsonResponse['completed']
        };
      } else {
        log('Failed to get appointment count: ${response.statusCode}');
        throw 'Failed to get appointment count: ${response.statusCode}';
      }
    } catch (e) {
      log('Exception during get appointment count: $e');
      throw 'Failed to get appointment count: $e';
    }
  }

  Future<bool?> endConsulation({required String appointmentId}) async {
    await fetchToken();
    final response =
        await HttpService.post(ApiEndPoint.endConsultation, token, {
      "data": {
        "id": appointmentId,
        "clientId": clinicId,
      }
    });
    if (response.statusCode == 200) {
      // log(response.data.toString());
      return response.data['ended']['yes']; //could be true or false
    } else {
      throw Exception('Failed to end consultaion');
    }
  }

  Future<String> makeReceipt({required String appointmentId}) async {
    await fetchToken();
    final response = await HttpService.post(ApiEndPoint.makeReceipt, token, {
      "data": {
        "clinicId": clinicId,
        "appointmentId": appointmentId,
      }
    });
    if (response.statusCode == 200) {
      if (response.data['isValid']) {
        log(response.data['invoiceId']);
        return response.data['invoiceId'];
      } else {
        throw Exception('Failed to make receipt');
      }
    } else {
      throw Exception('Failed to make receipt');
    }
  }

  Future<Invoice> getInvoiceById({required String invoiceId}) async {
    await fetchToken();
    final response = await HttpService.get(
        ApiEndPoint.getInvoiceById(invoiceId: invoiceId), token);
    if (response.statusCode == 200) {
      return Invoice.fromJson(response.data);
    } else {
      throw Exception('Failed to get invoice');
    }
  }

  Future<bool> addInvoiceDetails({
    required String invoiceId,
    required List<Map<String, dynamic>> treatments,
    required int discount,
  }) async {
    await fetchToken();
    final response = await HttpService.post(
        ApiEndPoint.addInvoiceDetails(invoiceId: invoiceId, clinicId: clinicId),
        token, {
      "data": {
        "treatments": treatments,
        "discount": discount,
      }
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to add invoice details');
    }
  }
}
