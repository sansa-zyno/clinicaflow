import 'dart:developer';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class AppointmentServices {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<AppointmentModel> fetchAppointments() async {
    await fetchToken();
    if (clinicId == "") {
      return AppointmentModel();
    }

    try {
      final response = await HttpService.get(
          ApiEndPoint.getAppointments(clinicId: clinicId), token);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        return AppointmentModel.fromJson(jsonResponse);
      } else {
        log('Failed to load appointments: ${response.statusCode}');
        throw 'Failed to load appointments: ${response.statusCode}';
      }
    } catch (e) {
      log('Exception during fetchAppointments: $e');
      throw 'Failed to load appointments: $e';
    }
  }

  Future<void> bookAppointment({
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
    log(mobile);
    log(name);
    log(gender);
    log(age);
    log(birthDate);
    log(appointmentDate);
    log(timeSlot);
    log(reason);
    log(virtualConsultation);
    log(doctorId);
    log(doctorName);
    log(clinicPatientId);

    final response = await HttpService.post(
      ApiEndPoint.createAppointment,
      token,
      body,
    );

    if (response.statusCode == 200) {
      print('Appointment created successfully.');
    } else {
      print('Failed to create appointment: ${response.data}');
    }
  }

  /*Future<List<Map<String, dynamic>>> fetchTimeSlots(String id) async {
    await fetchToken();
    final response =
        await HttpService.get(ApiEndPoint.getTimeSlotsById(id: id), token);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      List<Map<String, dynamic>> timeSlotsList = [];
      data.forEach((timeSlot) {
        final startTime = timeSlot['startTime'] ?? {};
        final endTime = timeSlot['endTime'] ?? {};
        timeSlotsList.add({
          'startTime': {
            'hours': startTime['hours'] ?? 0,
            'min': startTime['min'] ?? 0,
            'tt': startTime['tt'] ?? '',
          },
          'endTime': {
            'hours': endTime['hours'] ?? 0,
            'min': endTime['min'] ?? 0,
            'tt': endTime['tt'] ?? '',
          }
        });
      });
      log('time slots >>>>>>>' + timeSlotsList.toString());
      return timeSlotsList;
    } else {
      throw Exception('Failed to load time slots');
    }
  }*/

  Future<List<Map<String, String>>> fetchDoctors() async {
    await fetchToken();
    final response = await HttpService.get(
        ApiEndPoint.getDoctors(clinicId: clinicId), token);

    if (response.statusCode == 200) {
      final data = response.data;
      log(data.toString());
      List<Map<String, String>> doctorsList = [];
      if (data.isNotEmpty) {
        data.forEach((doctor) {
          final firstName = doctor['firstName'] ?? '';
          final lastName = doctor['lastName'] ?? '';
          final specialization = doctor['specialization'] ?? '';
          final id = doctor['_id'] ?? ''; // Retrieve doctor's ID
          doctorsList.add({
            'id': id,
            'firstName': firstName,
            'lastName': lastName,
            'specialization': specialization,
          });
        });
      }
      return doctorsList;
    } else {
      throw Exception('Failed to load doctors');
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
}
