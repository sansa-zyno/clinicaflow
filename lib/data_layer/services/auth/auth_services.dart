import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<String> loginUser(
      String phone, String password, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse("https://api-uhi.azurewebsites.net/api/authlogin"),
        body: {"emailOrPhone": phone, "password": password},
      );
      var result = json.decode(response.body);

      if (kDebugMode) {
        log("Result: $result");
      }

      if (result['success'] == true) {
        UserModel user = UserModel.fromMap(result['user']);

        if (kDebugMode) {
          log(user.toString());
        }
        String accessToken = result['token'];
        if (kDebugMode) {
          log("Access Token: $accessToken");
        }

        if (accessToken.isNotEmpty) {
          await SharedPrefService.setUser(user.toJson());
          log("User saved successfully");
          await SharedPrefService.setAccessToken(accessToken);
          if (kDebugMode) {
            log("Access Token saved successfully");
          }
          return "Login Success";
        } else {
          return "Access token is null";
        }
      } else {
        if (kDebugMode) {
          log(response.body);
        }
        return result['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
