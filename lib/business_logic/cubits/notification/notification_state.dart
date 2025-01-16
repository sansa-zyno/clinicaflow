// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState {
  final NotificationStates state;
  final List? notificationList;
  final int newNotificationsCount;

  NotificationState({
    required this.state,
    this.notificationList,
    this.newNotificationsCount = 0,
  });

  NotificationState copyWith({
    NotificationStates? state,
    List? notificationList,
    int? newNotificationsCount,
  }) {
    return NotificationState(
      state: state ?? this.state,
      notificationList: notificationList ?? this.notificationList,
      newNotificationsCount: newNotificationsCount ?? this.newNotificationsCount,
    );
  }
}
