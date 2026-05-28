import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlotDropDown extends StatefulWidget {
  final String? value;
  final List<Map<String, dynamic>>? availableTimeSlots;
  final DateTime? appointmentDate;
  final ValueChanged<String?> onChanged;

  const TimeSlotDropDown({
    Key? key,
    required this.value,
    required this.availableTimeSlots,
    required this.appointmentDate,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimeSlotDropDown> createState() => _TimeSlotDropDownState();
}

class _TimeSlotDropDownState extends State<TimeSlotDropDown> {
  /*fetchTimeSlots() async {
    await AppointmentServices().fetchTimeSlots();
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = ['Select Time Slot'];
    if (widget.availableTimeSlots != null && widget.appointmentDate != null) {
      int day = widget.appointmentDate!.weekday;
      String dayText = '';
      switch (day) {
        case 1:
          dayText = 'Mon';
          break;

        case 2:
          dayText = 'Tue';
          break;

        case 3:
          dayText = 'Wed';
          break;

        case 4:
          dayText = 'Thu';
          break;
        case 5:
          dayText = 'Fri';
          break;

        case 6:
          dayText = 'Sat';
          break;
        case 7:
          dayText = 'Sun';
          break;
        default:
          dayText = '';
      }
      log(dayText);
      for (int i = 0; i < widget.availableTimeSlots!.length; i++) {
        if ((widget.availableTimeSlots![i]['weekDay'] as List)
            .contains(dayText)) {
          timeSlots = generateTimeSlots(i);
        }
      }
    }

    return Container(
      height: 52,
      color: const Color(0xffF5F5F5),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
          ),
          value: widget.value,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          items: timeSlots.map((String value) {
            return DropdownMenuItem<String>(
              value: value == 'Select Time Slot' ? null : value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      value == 'Select Time Slot' ? Colors.grey : Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  List<String> generateTimeSlots(int i) {
    List<String> timeSlots = ['Select Time Slot'];
    if (widget.availableTimeSlots != null &&
        widget.availableTimeSlots!.isNotEmpty) {
      String startTimeText =
          widget.availableTimeSlots![i]['timeSlot'][0]['start'];
      String endTimeText = widget.availableTimeSlots![i]['timeSlot'][0]['end'];
      int interval = widget.availableTimeSlots![i]['slotDuration'];
      int startHour;
      int startMin;
      int endHour;
      int endMin;
      if (startTimeText.toLowerCase().contains('am')) {
        String time = startTimeText.split(' ')[0];
        startHour = int.parse(time.split(':')[0]);
        startMin = int.parse(time.split(':')[1]);
      } else {
        String time = startTimeText.split(' ')[0];
        startHour = int.parse(time.split(':')[0]);
        startHour = startHour + 12;
        startMin = int.parse(time.split(':')[1]);
      }
      if (endTimeText.toLowerCase().contains('am')) {
        String time = endTimeText.split(' ')[0];
        endHour = int.parse(time.split(':')[0]);
        endMin = int.parse(time.split(':')[1]);
      } else {
        String time = endTimeText.split(' ')[0];
        endHour = int.parse(time.split(':')[0]);
        endHour = endHour + 12;
        endMin = int.parse(time.split(':')[1]);
      }
      DateTime startTime = DateTime(2024, 1, 1, startHour, startMin);
      DateTime endTime = DateTime(2024, 1, 1, endHour, endMin);
      timeSlots.add('Slot 1');
      while (startTime.isBefore(endTime)) {
        DateTime nextTime = startTime.add(Duration(minutes: interval));
        timeSlots.add(
            "${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(nextTime)}");
        startTime = nextTime;
      }
    }
    return timeSlots;
  }
}
