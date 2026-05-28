import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataInitializer {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initializeSampleData() async {
    await _initializeAppointments();
  }

  static Future<void> _initializeAppointments() async {
    try {
      // Guard: skip seeding if appointments already exist
      final existing =
          await _firestore.collection('appointments').limit(1).get();

      if (existing.docs.isNotEmpty) {
        log('Appointments collection already has data — skipping seed.');
        return;
      }

      final appointments = [
        {
          'name': 'John Doe',
          'mobile': '08012345678',
          'age': 32,
          'gender': 'Male',
          'appointmentDate': '2026-04-10',
          'timeSlot': '09:00 AM - 09:30 AM',
          'virtualConsultation': false,
          'paymentStatus': true,
          'doctorName': 'Dr. Adewale Ogunleye',
          'patientId': 'PAT001',
          'clinicPatientId': 'CP001',
          'clientId': 'CLINIC001',
          'status': 'received',
          'reason': 'General checkup',
          'appointmentLogs': [
            {
              'time': DateTime.now().toIso8601String(),
              'message': 'Appointment created',
            },
          ],
        },
        {
          'name': 'Jane Smith',
          'mobile': '08098765432',
          'age': 28,
          'gender': 'Female',
          'appointmentDate': '2026-04-10',
          'timeSlot': '10:00 AM - 10:30 AM',
          'virtualConsultation': true,
          'paymentStatus': false,
          'doctorName': 'Dr. Ngozi Eze',
          'patientId': 'PAT002',
          'clinicPatientId': 'CP002',
          'clientId': 'CLINIC001',
          'status': 'received',
          'reason': 'Follow-up consultation',
          'appointmentLogs': [
            {
              'time': DateTime.now().toIso8601String(),
              'message': 'Appointment created',
            },
          ],
        },
        {
          'name': 'Emeka Okafor',
          'mobile': '07011223344',
          'age': 45,
          'gender': 'Male',
          'appointmentDate': '2026-04-11',
          'timeSlot': '11:00 AM - 11:30 AM',
          'virtualConsultation': false,
          'paymentStatus': true,
          'doctorName': 'Dr. Adewale Ogunleye',
          'patientId': 'PAT003',
          'clinicPatientId': 'CP003',
          'clientId': 'CLINIC001',
          'status': 'completed',
          'reason': 'Blood pressure review',
          'appointmentLogs': [
            {
              'time': DateTime.now()
                  .subtract(const Duration(hours: 2))
                  .toIso8601String(),
              'message': 'Appointment created',
            },
            {
              'time': DateTime.now().toIso8601String(),
              'message': 'Consultation ended',
            },
          ],
        },
        {
          'name': 'Aisha Bello',
          'mobile': '09055667788',
          'age': 22,
          'gender': 'Female',
          'appointmentDate': '2026-04-12',
          'timeSlot': '02:00 PM - 02:30 PM',
          'virtualConsultation': true,
          'paymentStatus': true,
          'doctorName': 'Dr. Ngozi Eze',
          'patientId': 'PAT004',
          'clinicPatientId': 'CP004',
          'clientId': 'CLINIC001',
          'status': 'received',
          'reason': 'Skin rash consultation',
          'appointmentLogs': [
            {
              'time': DateTime.now().toIso8601String(),
              'message': 'Appointment created',
            },
          ],
        },
        {
          'name': 'Tunde Bakare',
          'mobile': '08133445566',
          'age': 55,
          'gender': 'Male',
          'appointmentDate': '2026-04-09',
          'timeSlot': '08:00 AM - 08:30 AM',
          'virtualConsultation': false,
          'paymentStatus': true,
          'doctorName': 'Dr. Adewale Ogunleye',
          'patientId': 'PAT005',
          'clinicPatientId': 'CP005',
          'clientId': 'CLINIC001',
          'status': 'cancelled',
          'reason': 'Diabetes management review',
          'appointmentLogs': [
            {
              'time': DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toIso8601String(),
              'message': 'Appointment created',
            },
            {
              'time': DateTime.now().toIso8601String(),
              'message': 'Appointment cancelled by patient',
            },
          ],
        },
        {
          'name': 'Chidinma Nwosu',
          'mobile': '07066778899',
          'age': 35,
          'gender': 'Female',
          'appointmentDate': '2026-04-10',
          'timeSlot': '03:00 PM - 03:30 PM',
          'virtualConsultation': false,
          'paymentStatus': false,
          'doctorName': 'Dr. Ngozi Eze',
          'patientId': 'PAT006',
          'clinicPatientId': 'CP006',
          'clientId': 'CLINIC001',
          'status': 'received',
          'reason': 'Prenatal checkup',
          'appointmentLogs': [
            {
              'time': DateTime.now().toIso8601String(),
              'message': 'Appointment created',
            },
          ],
        },
      ];

      final batch = _firestore.batch();
      for (final appointment in appointments) {
        final docRef = _firestore.collection('appointments').doc();
        batch.set(docRef, appointment);
      }
      await batch.commit();

      log('Successfully seeded ${appointments.length} appointments.');
    } catch (e) {
      log('Error initializing appointments: $e');
    }
  }
}
