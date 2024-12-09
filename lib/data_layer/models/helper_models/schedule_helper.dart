class ScheduleHelper {
  ScheduleHelper();
  List<String> durations = ['None', 'After 3 days', 'After a week', 'Custom'];

  String selectedDuration = 'None';
  String? selectedTimeSlot;

  @override
  String toString() {
    return "ScheduleHelper(followUpDurations: $durations, selectedFollowUpDuration: $selectedDuration, selectedFollowUpTime: $selectedTimeSlot)";
  }
}
