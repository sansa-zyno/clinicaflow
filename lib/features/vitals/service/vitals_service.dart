import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinica_flow/features/vitals/model/vital.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

/// This communicates with the api client, gets data from api and converts
/// it into dart objects (models) that can be used in the app
class VitalsService {
  String token = "";
  String clinicId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<void> postVitals({
    required String patientId,
    required String appointmentId,
    required Map<String, dynamic> map,
  }) async {
    await fetchToken();
    try {
      await _firestore
          .collection('vitals')
          .doc('${patientId}_$appointmentId')
          .set(
        {
          ...map,
          'patientId': patientId,
          'appointmentId': appointmentId,
          'clientId': clinicId,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw 'Failed to save vitals: $e';
    }
  }

  Future<Vital> getVitals(
      {required String appointmentId, required String patientId}) async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('vitals')
          .where('patientId', isEqualTo: patientId)
          .where('appointmentId', isEqualTo: appointmentId)
          .where('clientId', isEqualTo: clinicId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return Vital();
      }

      final data = querySnapshot.docs.first.data();

      // Wrap in the structure expected by Vital.fromMapWithPersonalHistory
      final wrappedData = {
        'vitals': data['vitals'],
        'personalHistory': data['personalHistories'],
      };

      if (wrappedData['vitals'] != null) {
        return Vital.fromMapWithPersonalHistory(wrappedData);
      } else {
        return Vital();
      }
    } catch (e) {
      throw 'Failed to load saved vitals: $e';
    }
  }
}
