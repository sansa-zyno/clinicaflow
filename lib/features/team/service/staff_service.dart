import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/features/team/model/staff_model.dart';
import 'package:uuid/uuid.dart';

class StaffServices {
  String token = "";
  String clinicId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<String> getStaffId() async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('staffs')
          .where('clientId', isEqualTo: clinicId)
          .get();

      int currentStaffId = querySnapshot.docs.length + 1;
      String prefix = "STF";
      String suffix = "CLINIC";
      return '${prefix}_${currentStaffId}_$suffix';
    } catch (e) {
      throw Exception('Failed to generate staff id: $e');
    }
  }

  Future<void> createStaff(StaffModel staff, BuildContext context) async {
    await fetchToken();
    try {
      Map<String, dynamic> map = staff.toJson(context);
      String staffId = await getStaffId();
      String firestoreId = const Uuid().v4(); //firestore id
      map['id'] = firestoreId;
      map['staffId'] = staffId; //custom staff id
      map['clientId'] = clinicId;
      await _firestore.collection('staffs').doc(firestoreId).set(map);
    } catch (e) {
      throw Exception('Failed to create staff: $e');
    }
  }

  Future<void> updateStaff(
      StaffModel staff, BuildContext context, String id) async {
    await fetchToken();
    try {
      Map<String, dynamic> map = staff.toJson(context);
      await _firestore.collection('staffs').doc(id).update(map);
    } catch (e) {
      throw Exception('Failed to update staff: $e');
    }
  }

  Future<List<StaffModel>> fetchStaffs() async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('staffs')
          .where('clientId', isEqualTo: clinicId)
          .get();
      List<StaffModel> staffList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return StaffModel.fromJson(data);
      }).toList();
      return staffList;
    } catch (e) {
      log('Exception during fetchStaffs: $e');
      throw Exception('Failed to load staffs: $e');
    }
  }

  Future<StaffModel> getStaffById(String id) async {
    await fetchToken();
    log("ID : $id");
    try {
      final docSnapshot = await _firestore.collection('staffs').doc(id).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        return StaffModel.fromJson(data);
      } else {
        throw Exception('Staff not found');
      }
    } catch (e) {
      log('Exception during getStaffById: $e');
      throw Exception('Failed to fetch staff detail: $e');
    }
  }

  Future<void> deleteStaff(String id) async {
    await fetchToken();
    try {
      await _firestore.collection('staffs').doc(id).delete();
      if (kDebugMode) {
        print('Delete Staff successful');
      }
    } catch (e) {
      log('Exception during deleteStaff: $e');
      throw Exception('Failed to delete staff: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> fetchDoctors() async {
    await fetchToken();
    try {
      final querySnapshot = await _firestore
          .collection('staffs')
          .where('clientId', isEqualTo: clinicId)
          .where('isDoctor', isEqualTo: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return data;
        }).toList();
      } else {
        return null;
      }
    } catch (e) {
      log('Exception during fetchDoctors: $e');
      throw Exception('Failed to load doctors: $e');
    }
  }
}
