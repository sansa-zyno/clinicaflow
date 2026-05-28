import 'package:clinica_flow/features/appointment/model/day.dart';
import 'package:clinica_flow/core/utils/extensions.dart/string_extensions.dart';

enum PrescriptionTemplates {
  template_1('assets/png/prescription_template.png'),
  template_2('assets/png/prescription_template.png'),
  template_3('assets/png/prescription_template.png');

  final String imgPath;
  const PrescriptionTemplates(this.imgPath);

  String get describe => name.split('_').join(' ').capitalize;

  static PrescriptionTemplates fromString(String value) {
    switch (value) {
      case 'Template 1':
        return PrescriptionTemplates.template_1;
      case 'Template 2':
        return PrescriptionTemplates.template_2;
      case 'Template 3':
        return PrescriptionTemplates.template_3;
      default:
        return PrescriptionTemplates.template_1;
    }
  }
}

enum WeekDays {
  mon(Day(dayOfWeek: 1)),
  tue(Day(dayOfWeek: 2)),
  wed(Day(dayOfWeek: 3)),
  thurs(Day(dayOfWeek: 4)),
  fri(Day(dayOfWeek: 5)),
  sat(Day(dayOfWeek: 6)),
  sun(Day(dayOfWeek: 7));

  String get describe => name;

  final Day day;
  const WeekDays(this.day);

  static WeekDays fromString(String value) {
    switch (value) {
      case 'mon':
        return WeekDays.mon;
      case 'tue':
        return WeekDays.tue;
      case 'wed':
        return WeekDays.wed;
      case 'thurs':
        return WeekDays.thurs;
      case 'fri':
        return WeekDays.fri;
      case 'sat':
        return WeekDays.sat;
      default:
        return WeekDays.sun;
    }
  }
}
