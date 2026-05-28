import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../../../core/utils/shared_preferences_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  static Future<String?> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      if (user != null) {
        UserModel? userModel = await getUser(user.uid);
        if (userModel != null) {
          await SharedPrefService.setUser(userModel.toJson());
        }
        return user.uid;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (signInError) {
      throw signInError.code;
    }
  }

  // Get user by ID
  static Future<UserModel?> getUser(String userId) async {
    try {
      final doc =
          await _firestore.collection(_usersCollection).doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
