class ScheduleHelper {
  ScheduleHelper();
  List<String> followUpDurations = ['None', 'After 3 days', 'After a week', 'Custom'];

  String selectedFollowUpDuration = 'None';
  String? selectedFollowUpTime;
  bool notifyOnWhatsapp = false;
  bool cancelAppointment = false;

  Map<String, dynamic> toMap() {
    return {
      "selectedFollowUpDuration": selectedFollowUpDuration,
      "selectedFollowUpTime": selectedFollowUpTime,
      "notifyOnWhatsapp": notifyOnWhatsapp,
      'cancelAppointment': cancelAppointment
    };
  }

  @override
  String toString() {
    return "ScheduleHelper(followUpDurations: $followUpDurations, selectedFollowUpDuration: $selectedFollowUpDuration, selectedFollowUpTime: $selectedFollowUpTime, notifyOnWhatsapp: $notifyOnWhatsapp, cancelAppointment: $cancelAppointment)";
  }
}
