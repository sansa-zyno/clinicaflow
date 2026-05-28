// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Day extends Equatable {
  final int dayOfWeek;
  const Day({
    required this.dayOfWeek,
  });

  @override
  List<Object?> get props => [dayOfWeek];

  String get day {
    switch (dayOfWeek) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Invalid day number';
    }
  }

  factory Day.fromString(String dayOfWeek) {
    int day = 0;
    switch (dayOfWeek) {
      case 'Mon':
        day = 1;
      case 'Tue':
        day = 2;
      case 'Wed':
        day = 3;
      case 'Thu':
        day = 4;
      case 'Fri':
        day = 5;
      case 'Sat':
        day = 6;
      case 'Sun':
        day = 7;
      default:
        day = 0;
    }
    return Day(
      dayOfWeek: day,
    );
  }

  /* Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayOfWeek': dayOfWeek,
    };
  }*/

  /* factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      dayOfWeek: map['dayOfWeek'] as int,
    );
  }*/

  //String toJson() => json.encode(toMap());

  //factory Day.fromJson(String source) => Day.fromMap(json.decode(source) as Map<String, dynamic>);*/
}
