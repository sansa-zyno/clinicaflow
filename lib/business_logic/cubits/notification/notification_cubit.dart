import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState(state: NotificationStates.initial));

  fetchNotifications() async {
    emit(state.copyWith(state: NotificationStates.fetchingNotifications));

    try {
      String? notificationString = await SharedPrefService.getString("notifications");
      List? notificationList = notificationString != null ? jsonDecode(notificationString) : [];

      emit(state.copyWith(
        state: NotificationStates.notificationsFetched,
        notificationList: notificationList,
        newNotificationsCount: notificationList?.length ?? 0,
      ));
    } catch (error) {
      log('Failed to fetch notifications: $error');
      emit(state.copyWith(state: NotificationStates.fetchingNotificationsFailed));
    }
  }
}
