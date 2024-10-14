import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';

class ViewPatientDetailsPopup extends StatelessWidget {
  final Appointment appointment;

  const ViewPatientDetailsPopup({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    // int age = currentDate.year - dob.year;

    // // Check if the birthday has occurred this year
    // bool hasBirthdayOccured = currentDate.month > dob.month ||
    //     (currentDate.month == dob.month && currentDate.day >= dob.day);

    // // If birthday hasn't occurred yet, subtract one year from age
    // if (!hasBirthdayOccured) {
    //   age--;
    // }

    return AlertDialog(
      title: const Text('Appointment Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${appointment.name}'),
          Text('Mobile Number: ${appointment.mobile}'),
          // Text(
          //     'Date of Birth: ${DateFormat('yyyy-MM-dd').format(dob)}'), // Show DOB
          // Text('Age: $age'), // Show calculated age
          // Add more details as needed
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
