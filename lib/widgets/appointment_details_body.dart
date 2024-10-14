import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/widgets/action_button.dart';
import 'package:healtether_clinic_app/widgets/appointment_info.dart';
import 'package:healtether_clinic_app/widgets/time_line_items.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsBody extends StatelessWidget {
  final Appointment appointment;
  final int slotNumber;
  final TimeOfDay? timeSlot;

  const AppointmentDetailsBody({
    Key? key,
    required this.appointment,
    required this.slotNumber,
    this.timeSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 240,
          width: double.infinity,
          color: Colors.grey[200],
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppointmentInfo(
                slotNumber: slotNumber,
                appointment: appointment,
                timeSlot: timeSlot,
              ),
              const AppointmentActionButtons(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('TIMELINE',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
              const Divider(thickness: 1.6, color: Color(0xff03BF9C)),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimelineItemPage()),
                  );
                },
                child: TimelineItem(
                  iconColor: const Color(0xff740AC7),
                  text:
                      'Consultation appointment is Scheduled on ${DateFormat('d MMM, yyyy').format(DateTime.parse(appointment.appointmentDate ?? ''))} .',
                  date: '01 April, 2024',
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
