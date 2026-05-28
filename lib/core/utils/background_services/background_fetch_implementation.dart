import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/notification/service/notifications_services.dart';
import '../../../features/notification/viewmodel/notification_cubit.dart';
import '../../network/api_endpoints.dart';
import '../../network/http.service.dart';
import '../shared_preferences_service.dart';

Future<Map<String, dynamic>?> api() async {
  String token = await SharedPrefService.getAccessToken() ?? "";
  String clinicId = await SharedPrefService.getClinicId() ?? "";
  if (token != '' && clinicId != '') {
    final response = await HttpService.get(
        ApiEndPoint.getNotifications(clinicId: clinicId), token);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>>? list = response.data != null
          ? List<Map<String, dynamic>>.from(response.data['data'] ?? [])
          : null;
      if (list != null) {
        DateTime now = DateTime.now();
        String? savedIdsString = await SharedPrefService.getString("savedIds");
        List savedIds =
            savedIdsString != null ? jsonDecode(savedIdsString) : [];
        Map<String, dynamic>? lastItem = list.lastWhere((element) {
          DateTime showTime = DateTime.parse(element['showTime']);
          return showTime.difference(now).inDays >= 0 &&
              !savedIds.contains(element["_id"]);
        }, orElse: () {
          return {}; //to prevent bad state error
        });
        return lastItem;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } else {
    return null;
  }
}

//in main method, call BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  //print(taskId);
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    BackgroundFetch.finish(taskId);
    return;
  }
  // Do your work here...
  try {
    //SharedPreferences? prefs = await SharedPreferences.getInstance();
    await SharedPrefService.initSharedPref();
    Map<String, dynamic>? apiResult = await api();
    if (apiResult != null && apiResult.isNotEmpty) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(20),
            channelKey:
                NotificationService.appNotificationChannel().channelKey!,
            title: "${apiResult['header']}",
            body: "${apiResult["notificationMessage"]}",
            icon: "resource://drawable/res_launcher",
            // notificationLayout: NotificationLayout.BigPicture,
            //bigPicture: "resource://drawable/launcher_icon",
            payload: {
              "id": "${apiResult['_id']}",
              "header": "${apiResult['header']}",
              "notificationMessage": "${apiResult["notificationMessage"]}",
              "showTime": "${apiResult["showTime"]}",
              "seen": "${apiResult["seen"]}",
            }),
      );
      String? savedIdsString = await SharedPrefService.getString("savedIds");
      List savedIds = savedIdsString != null ? jsonDecode(savedIdsString) : [];
      savedIds.insert(0, apiResult['_id']);
      await SharedPrefService.setString("savedIds", jsonEncode(savedIds));
    }
  } catch (e) {
    dev.log(e.toString());
    throw Exception(e);
  }
  BackgroundFetch.finish(taskId);
}

class BackgroundFetchPlugin {
//in initState method, call initPlatformState();
  // Platform messages are asynchronous, so we initialize in an async method.
  static Future<void> initPlatformState(BuildContext context) async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 1,
            forceAlarmManager: true,
            stopOnTerminate: false,
            enableHeadless: true,
            startOnBoot: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      //print("[BackgroundFetch] Event received $taskId");
      try {
        Map<String, dynamic>? apiResult = await api();
        if (apiResult != null && apiResult.isNotEmpty) {
          AwesomeNotifications()
              .createNotification(
                content: NotificationContent(
                    id: Random().nextInt(20),
                    channelKey: NotificationService.appNotificationChannel()
                        .channelKey!,
                    title: "${apiResult['header']}",
                    body: "${apiResult["notificationMessage"]}",
                    icon: "resource://drawable/res_launcher",
                    // notificationLayout: NotificationLayout.BigPicture,
                    //bigPicture: "resource://drawable/launcher_icon",
                    payload: {
                      "id": "${apiResult['_id']}",
                      "header": "${apiResult['header']}",
                      "notificationMessage":
                          "${apiResult["notificationMessage"]}",
                      "showTime": "${apiResult["showTime"]}",
                      "seen": "${apiResult["seen"]}",
                    }),
              )
              .then((value) =>
                  context.read<NotificationCubit>().fetchNotifications());
          String? savedIdsString =
              await SharedPrefService.getString("savedIds");
          List savedIds =
              savedIdsString != null ? jsonDecode(savedIdsString) : [];
          savedIds.insert(0, apiResult['_id']);
          await SharedPrefService.setString("savedIds", jsonEncode(savedIds));
        }
      } catch (e) {
        dev.log(e.toString());
        throw Exception(e);
      }
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      BackgroundFetch.finish(taskId);
    });
    if (!context.mounted) return;
  }
}
