import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? prefs;

//sharedpreferences
  static Future<bool> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Future<void> setAccessToken(String token) async {
    await prefs!.setString("token", token);
  }

  static Future<String?> getAccessToken() async {
    return prefs!.getString("token");
  }

  static Future<void> deleteAccessToken() async {
    await prefs!.remove("token");
  }

  static Future<void> setClinicId(String id) async {
    await prefs!.setString("clinicId", id);
  }

  static Future<String?> getClinicId() async {
    return prefs!.getString('clinicId');
  }

  static Future<void> deleteClinicId() async {
    await prefs!.remove("clinicId");
  }

  static Future<void> setFirstTimeOnPrescriptionScreen(bool isFirsTime) async {
    await prefs!.setBool("isFirstTimeOnPrescriptionScreen", isFirsTime);
  }

  static Future<bool?> getFirstTimeOnPrescriptionScreen() async {
    return prefs!.getBool("isFirstTimeOnPrescriptionScreen");
  }

  static Future<void> setUser(String userDetails) async {
    await prefs!.setString('user', userDetails);
  }

  static Future<String?> getUser() async {
    return prefs!.getString('user');
  }

  static Future<void> deleteUser() async {
    await prefs!.remove("user");
  }

  static Future<bool> setString(String key, String val) async {
    prefs!.setString(key, val);
    return true;
  }

  static Future<String?> getString(String key) async {
    return prefs!.getString(key);
  }
}
