class Appointments {
  String name;
  String mobileNo;
  String doctor;
  DateTime? selectedDate;
  bool isVirtualConsultation;
  bool isCancelled;
  DateTime? dob;

  Appointments({
    required this.name,
    required this.mobileNo,
    required this.doctor,
    required this.selectedDate,
    required this.isVirtualConsultation,
    required this.isCancelled,
    required this.dob,
  });

  static fromJson(Map<String, Object> map) {}
}
