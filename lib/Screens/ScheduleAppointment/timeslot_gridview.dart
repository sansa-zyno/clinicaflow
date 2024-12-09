import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/time_slot.dart';
import 'package:intl/intl.dart';

class TimeSlotGridView extends StatefulWidget {
  final List<Map<String, dynamic>>? availableTimeSlots;
  final DateTime? appointmentDate;
  final Function(String) onSelected;

  const TimeSlotGridView({
    Key? key,
    required this.availableTimeSlots,
    required this.appointmentDate,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<TimeSlotGridView> createState() => _TimeSlotGridViewState();
}

class _TimeSlotGridViewState extends State<TimeSlotGridView> {
  int idx = -1;
  //getting one of the availableTimeSlots
  Map<String, dynamic> filterAppointments(int i) {
    if (widget.availableTimeSlots != null) {
      List<TimeSlot> res =
          List<Map<String, dynamic>>.from(widget.availableTimeSlots![i]['timeSlot']).map((e) => TimeSlot.fromJson(jsonEncode(e))).toList();
      res = res.where((element) => element.start != null && element.finish != null).toList();
      return {"_duration": widget.availableTimeSlots![i]['slotDuration'].toString(), "_timeSlots": res};
    } else {
      return {"_duration": '', "_timeSlots": []};
    }
  }

  int timeSlotTitle = 0;
  int appointmentIndex = 0;
  List<String> timeSlots = [];

  @override
  Widget build(BuildContext context) {
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
        if ((widget.availableTimeSlots![i]['weekDay'] as List).contains(dayText)) {
          appointmentIndex = i;
          timeSlots = generateTimeSlots(appointmentIndex, timeSlotTitle);
        }
      }
    }
    if (timeSlots.isEmpty) {
      context.pop();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    if (timeSlotTitle > 0) {
                      timeSlotTitle = timeSlotTitle - 1;
                      if (timeSlotTitle >= 0) {
                        log(timeSlots.toString());
                        timeSlots = generateTimeSlots(appointmentIndex, timeSlotTitle);
                        //context.pop();
                        //showTimeSlot();
                        setState(() {});
                      } else {
                        timeSlotTitle = 0;
                        setState(() {});
                      }
                    }
                  },
                  child: Icon(Icons.arrow_back_ios, size: 20)),
              Text('Slot ${timeSlotTitle + 1}'),
              InkWell(
                onTap: () {
                  if (timeSlotTitle < filterAppointments(appointmentIndex)['_timeSlots'].length) {
                    timeSlotTitle = timeSlotTitle + 1;
                    if (timeSlotTitle < filterAppointments(appointmentIndex)['_timeSlots'].length) {
                      log(timeSlots.toString());
                      log(timeSlotTitle.toString());
                      timeSlots = generateTimeSlots(appointmentIndex, timeSlotTitle);
                      setState(() {});
                      //context.pop();
                      //showTimeSlot();
                    } else {
                      log('here');
                      timeSlotTitle = timeSlotTitle - 1;
                      setState(() {});
                    }
                  }
                },
                child: Icon(Icons.arrow_forward_ios, size: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GridView.builder(
                  itemCount: timeSlots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 5.0, crossAxisSpacing: 15, mainAxisSpacing: 12),
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          idx = index;
                          setState(() {});
                          widget.onSelected(timeSlots[index]);
                          context.pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: idx == index ? const Color(0xff198E79) : null,
                              border: Border.all(color: Color(0xffE1E1E1)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              timeSlots[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: idx == index ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }

  List<String> generateTimeSlots(int appointmentIndex, int timeSlotIndex) {
    List<String> timeSlots = [];
    if ((filterAppointments(appointmentIndex)['_timeSlots'] as List<TimeSlot>).isNotEmpty &&
        (filterAppointments(appointmentIndex)['_duration'] as String).isNotEmpty) {
      String startTimeText = filterAppointments(appointmentIndex)['_timeSlots'][timeSlotIndex].start?.format(context) ?? '';
      String endTimeText = filterAppointments(appointmentIndex)['_timeSlots'][timeSlotIndex].finish?.format(context) ?? '';
      int interval = int.parse(filterAppointments(appointmentIndex)['_duration']);
      int startHour;
      int startMin;
      int endHour;
      int endMin;
      log('start-time   ${startTimeText.toLowerCase()}');
      log('end-time   ${endTimeText.toLowerCase()}');
      if (startTimeText.toLowerCase().contains('am')) {
        //am
        String time = startTimeText.split(' ')[0];
        startHour = int.parse(time.split(':')[0]);
        if (startHour == 12) {
          //12:00 am == 0 hour in 24 hours clock
          startHour = 0;
        }
        startMin = int.parse(time.split(':')[1]);
      } else {
        //pm
        String time = startTimeText.split(' ')[0];
        startHour = int.parse(time.split(':')[0]);
        if (startHour == 12) {
          //avoid 24:00 which is 12:00 am
          startHour = startHour;
        } else {
          //24 hours equivalent
          startHour = startHour + 12;
        }
        startMin = int.parse(time.split(':')[1]);
      }
      if (endTimeText.toLowerCase().contains('am')) {
        //am
        String time = endTimeText.split(' ')[0];
        endHour = int.parse(time.split(':')[0]);
        if (endHour == 12) {
          //12:00 am == 0 hour in 24 hours clock
          endHour = 0;
        }
        endMin = int.parse(time.split(':')[1]);
      } else {
        //pm
        String time = endTimeText.split(' ')[0];
        endHour = int.parse(time.split(':')[0]);
        if (endHour == 12) {
          //avoid 24:00 which is 12:00 am
          endHour = endHour;
        } else {
          //24 hours equivalent
          endHour = endHour + 12;
        }
        endMin = int.parse(time.split(':')[1]);
      }
      DateTime startTime = DateTime(2024, 1, 1, startHour, startMin);
      DateTime endTime = DateTime(2024, 1, 1, endHour, endMin);
      while (startTime.isBefore(endTime)) {
        DateTime nextTime = startTime.add(Duration(minutes: interval));
        timeSlots.add("${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(nextTime)}");
        startTime = nextTime;
      }
    }
    return timeSlots;
  }
}
