import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinica_flow/features/past_medical_history/model/history_item.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

class PastMedicalHistoryService {
  String token = "";
  String clinicId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<void> postPastMedicalHistory(
      {required String patientId,
      required List<Map<String, dynamic>> medication,
      required List<Map<String, dynamic>> allergies,
      required List<Map<String, dynamic>> familyHistory,
      required List<Map<String, dynamic>> pastHistory,
      required List<Map<String, dynamic>> pastProcedureHistory}) async {
    await fetchToken();
    try {
      await _firestore.collection('past_medical_history').doc(patientId).set(
        {
          'allergies': allergies,
          'medication': medication,
          'familyHistory': familyHistory,
          'pastHistory': pastHistory,
          'pastProcedureHistory': pastProcedureHistory,
          'patientId': patientId,
          'clientId': clinicId,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw 'Failed to save past medical history: $e';
    }
  }

  Future<Map<String, List<HistoryItem>?>> getPastMedicalHistory(
      {required String patientId}) async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('past_medical_history')
          .where('patientId', isEqualTo: patientId)
          .where('clientId', isEqualTo: clinicId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {
          "allergies": null,
          "medication": null,
          "familyHistory": null,
          "pastHistory": null,
          "pastProcedureHistory": null,
        };
      }

      final data = querySnapshot.docs.first.data();

      List<HistoryItem>? allergies = (data['allergies'] as List?)
          ?.map((e) => HistoryItem.fromMap(Map<String, dynamic>.from(e)))
          .toList();
      List<HistoryItem>? medication = (data['medication'] as List?)
          ?.map((e) => HistoryItem.fromMap(Map<String, dynamic>.from(e)))
          .toList();
      List<HistoryItem>? familyHistory = (data['familyHistory'] as List?)
          ?.map((e) => HistoryItem.fromMap(Map<String, dynamic>.from(e)))
          .toList();
      List<HistoryItem>? pastHistory = (data['pastHistory'] as List?)
          ?.map((e) => HistoryItem.fromMap(Map<String, dynamic>.from(e)))
          .toList();
      List<HistoryItem>? pastProcedureHistory =
          (data['pastProcedureHistory'] as List?)
              ?.map((e) => HistoryItem.fromMap(Map<String, dynamic>.from(e)))
              .toList();

      return {
        "allergies": allergies,
        "medication": medication,
        "familyHistory": familyHistory,
        "pastHistory": pastHistory,
        "pastProcedureHistory": pastProcedureHistory,
      };
    } catch (e) {
      throw 'Failed to load past medical history: $e';
    }
  }
}
