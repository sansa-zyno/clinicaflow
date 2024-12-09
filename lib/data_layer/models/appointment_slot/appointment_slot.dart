// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/time_slot.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/day.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:uuid/uuid.dart';

class AppointmentSlot {
  String id;
  List<TimeSlot> timeSlots;
  String duration;
  List<Day> days;

  AppointmentSlot({required this.id, required this.timeSlots, required this.duration, required this.days});

  AppointmentSlot copyWith({
    String? id,
    List<TimeSlot>? timeSlots,
    String? duration,
    List<Day>? days,
  }) {
    return AppointmentSlot(
      id: id ?? this.id,
      timeSlots: timeSlots ?? this.timeSlots,
      duration: duration ?? this.duration,
      days: days ?? this.days,
    );
  }

  void removeDay(Day day) {
    days.remove(day);
  }

  void addDay(Day day) {
    // ensures timeslots are unique
    days.add(day);
    days = days.toSet().toList();

    log("Updated days: $days");
  }

  bool hasDay(Day day) {
    bool selected = false;
    days.forEach((el) {
      if (el.dayOfWeek == day.dayOfWeek) selected = true;
    });

    return selected;
  }

  @override
  String toString() => 'AppointmentSlot(id: $id, timeSlots: $timeSlots, duration: $duration, days: $days)';

  Map<String, dynamic> toMap(BuildContext context) {
    return <String, dynamic>{
      'key': id,
      'timeSlot': timeSlots.map((x) => x.toMap(context)).toList(),
      'slotDuration': duration,
      'weekDay': days.map((x) => x.day).toList(), //x.day is a getter that does the conversion from int day to string day
    };
  }

  factory AppointmentSlot.fromMap(Map<String, dynamic> map) {
    return AppointmentSlot(
      id: map['_id'],
      timeSlots: map["timeSlot"] == null
          ? []
          : List<TimeSlot>.from(
              (map['timeSlot'] as List<dynamic>).map<TimeSlot>(
                (x) => TimeSlot.fromMap(x as Map<String, dynamic>),
              ),
            ),
      duration: map['slotDuration'].toString(),
      days: map['weekDay'] == null
          ? []
          : List<Day>.from(
              (map['weekDay'] as List<dynamic>).map<Day>(
                (x) => Day.fromString(x as String),
              ),
            ),
    );
  }

  factory AppointmentSlot.empty() {
    return AppointmentSlot(id: const Uuid().v4(), timeSlots: [TimeSlot(const Uuid().v4())], duration: '', days: []);
  }

  String toJson(BuildContext context) => json.encode(toMap(context));
  factory AppointmentSlot.fromJson(String source) => AppointmentSlot.fromMap(json.decode(source) as Map<String, dynamic>);
}
