import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinica_flow/features/patient/model/patient_model.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils/shared_preferences_service.dart';

class PatientService {
  String token = "";
  String clinicId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<String> getPatientId() async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('patients')
          .where('clientId', isEqualTo: clinicId)
          .get();

      int currentPatientId = querySnapshot.docs.length + 1;
      String prefix = "PT";
      String suffix = "CLINIC";
      return '${prefix}_${currentPatientId}_$suffix';
    } catch (e) {
      throw Exception('Failed to generate patient id: $e');
    }
  }

  Future<void> postPatient(PatientModel patient) async {
    await fetchToken();
    try {
      Map<String, dynamic> map = patient.toJson();
      String patientId = await getPatientId();
      String firestoreId = const Uuid().v4();
      map['id'] = firestoreId;
      map['patientId'] = patientId;
      map['clientId'] = clinicId;
      await _firestore.collection('patients').doc(firestoreId).set(map);
    } catch (e) {
      log('Exception during postPatient: $e');
      throw Exception('Failed to create patient: $e');
    }
  }

  Future<void> updatePatient(PatientModel patient, String id) async {
    await fetchToken();
    try {
      Map<String, dynamic> map = patient.toJson();
      map['id'] = id;
      await _firestore.collection('patients').doc(id).update(map);
    } catch (e) {
      throw Exception('Failed to update patient: $e');
    }
  }

  Future<List<PatientModel>> fetchPatients() async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('patients')
          .where('clientId', isEqualTo: clinicId)
          .get();

      List<PatientModel> patientList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return PatientModel.fromJson(data);
      }).toList();
      return patientList;
    } catch (e) {
      log('Exception during fetchPatients: $e');
      throw Exception('Failed to load patients: $e');
    }
  }

  Future<PatientModel> getPatientById(String id) async {
    await fetchToken();
    try {
      final docSnapshot = await _firestore.collection('patients').doc(id).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        return PatientModel.fromJson(data);
      } else {
        throw Exception('Patient not found');
      }
    } catch (e) {
      log('Exception during getPatientById: $e');
      throw Exception('Failed to fetch patient details: $e');
    }
  }

  Future<void> deletePatient(String id) async {
    await fetchToken();
    try {
      await _firestore.collection('patients').doc(id).delete();
      if (kDebugMode) {
        print('Delete Patient successful');
      }
    } catch (e) {
      log('Exception during deletePatient: $e');
      throw Exception('Failed to delete patient: $e');
    }
  }
}
