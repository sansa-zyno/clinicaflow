// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot {
  final String id;
  final TimeOfDay? start;
  final TimeOfDay? finish;
  final String? startStr;
  final String? finishStr;
  const TimeSlot(
    this.id, {
    this.start,
    this.finish,
    this.startStr,
    this.finishStr,
  });

  TimeSlot copyWith({TimeOfDay? start, TimeOfDay? finish, String? startStr, String? finishStr}) {
    return TimeSlot(id,
        start: start ?? this.start, finish: finish ?? this.finish, startStr: startStr ?? this.startStr, finishStr: finishStr ?? this.finishStr);
  }

  int? duration() {
    print("Calculating duration...");
    if (start == null || finish == null) return null;
    final now = DateTime.now();
    final dateTime1 = DateTime(now.year, now.month, now.day, start!.hour, start!.minute);
    final dateTime2 = DateTime(now.year, now.month, now.day, finish!.hour, finish!.minute);
    final difference = dateTime2.difference(dateTime1).inMinutes;
    print("Difference in time: $difference");
    return difference;
  }

  @override
  bool operator ==(covariant TimeSlot other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TimeSlot(id: $id, start: $start, finish: $finish, startStr: $startStr, finishStr: $finishStr)';
  }

  TimeSlot clear() {
    return TimeSlot(id);
  }

  Map<String, dynamic> toMap(BuildContext context) {
    print('here');
    return <String, dynamic>{
      '_id': id,
      'start': start?.format(context) ?? '',
      'end': finish?.format(context) ?? '',
      'startStr': startStr,
      'finishStr': finishStr,
    };
  }

  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      map['_id'] as String,
      start: () {
        try {
          if (map['start'] != null) {
            return TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(map['start'].toString()));
          } else {
            return null;
          }
        } catch (e) {
          return null;
        }
      }(),
      finish: () {
        try {
          if (map['end'] != null) {
            return TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(map['end'].toString()));
          } else {
            return null;
          }
        } catch (e) {
          return null;
        }
      }(),
      startStr: map['startStr'] != null ? map['startStr'] as String : null,
      finishStr: map['finishStr'] != null ? map['finishStr'] as String : null,
    );
  }

  String toJson(BuildContext context) => json.encode(toMap(context));

  factory TimeSlot.fromJson(String source) => TimeSlot.fromMap(json.decode(source) as Map<String, dynamic>);
}
