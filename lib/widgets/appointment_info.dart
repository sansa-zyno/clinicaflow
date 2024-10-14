import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:intl/intl.dart';

class AppointmentInfo extends StatelessWidget {
  final int slotNumber;
  final Appointment appointment;
  final TimeOfDay? timeSlot;

  const AppointmentInfo({
    Key? key,
    required this.slotNumber,
    required this.appointment,
    required this.timeSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Attending Doctor',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(
              'SLOT-$slotNumber',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5351C7)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.doctorName ?? '',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  appointment.mobile ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
            Text(
              appointment.timeSlot ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Text(
          DateFormat('d MMM, yyyy')
              .format(DateTime.parse(appointment.appointmentDate ?? '')),
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        Divider(thickness: 3, color: Colors.grey[300]),
      ],
    );
  }
}
