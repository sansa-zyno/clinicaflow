import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

@pragma('vm:entry-point')
Future<void> onActionReceived(ReceivedAction receivedAction) async {}

@pragma('vm:entry-point')
Future<void> onNotificationDisplayed(ReceivedNotification receivedNotification) async {
  if (receivedNotification.payload != null) {
    String? notificationString = await SharedPrefService.getString("notifications");
    List notificationList = notificationString != null ? jsonDecode(notificationString) : [];
    notificationList.insert(0, {
      "id": receivedNotification.payload!["id"],
      "header": receivedNotification.payload!["header"],
      "notificationMessage": receivedNotification.payload!["notificationMessage"],
      "showTime": receivedNotification.payload!["showTime"],
      "seen": receivedNotification.payload!["seen"],
    });
    await SharedPrefService.setString("notifications", jsonEncode(notificationList));
    //log(notificationList.toString());
  }
}

@pragma('vm:entry-point')
Future<void> onNotificationDismissed(ReceivedAction receivedAction) async {}

class NotificationService {
  static initializeAwesomeNotification() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_launcher',
      [
        appNotificationChannel(),
      ],
    );
    //requet notifcation permission if not allowed
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static NotificationChannel appNotificationChannel() {
    return NotificationChannel(
        channelKey: 'Healtether',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for Healtether app',
        importance: NotificationImportance.High,
        playSound: true);
  }

  static listenToActions() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceived,
        onNotificationDisplayedMethod: onNotificationDisplayed,
        onDismissActionReceivedMethod: onNotificationDismissed);
  }
}
